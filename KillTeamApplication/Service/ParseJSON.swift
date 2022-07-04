//
//  ParseJSON.swift
//  KillTeamApplication
//
//  Created by Apple on 04.07.2022.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import UIKit

final class ParseJSON {
    
    private let databaseQueue = DispatchQueue.global(qos: .utility)
    
    private let tacOpsFileName = "TacOps"
    private let dataFileName = "AllFaction"
    private let keyChecksumDatabase = "ChecksumDatabase"
    private let ployCommandReRoll = "PloyCommandReRoll"
    
    func parseTacOps(completion: @escaping (([TacOp]) -> Void)) {
        databaseQueue.async {
            guard let path = Bundle.main.path(forResource: self.tacOpsFileName, ofType: "json") else {
                print("DEBUG: Tac Ops - Incorrect File Name")
                return
            }
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                let tacOps = try JSONDecoder().decode([TacOp].self, from: jsonData as Data)
                DispatchQueue.main.async {
                    completion(tacOps)
                }
            } catch let error {
                print("DEBUG: Tac Ops - parse error: \(error.localizedDescription)")
            }
        }
    }
    
    func parsePloyCommandReRoll(completion: @escaping ((Ploy) -> Void)) {
        databaseQueue.async { [self] in
            
            guard let path = Bundle.main.path(forResource: self.ployCommandReRoll, ofType: "json") else {
                print("DEBUG: Ploy Command Re-Roll - Incorrect File Name")
                return
            }
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                let commandReRoll = try JSONDecoder().decode(Ploy.self, from: jsonData as Data)
                DispatchQueue.main.async {
                    completion(commandReRoll)
                }
            } catch let error {
                print("DEBUG: Ploy Command Re-Roll - parse error: \(error.localizedDescription)")
            }
        }
    }
    
    func parseJson(store: StoreProtocol, storage: StorageProtocol, completion: @escaping ()->Void) {
        databaseQueue.async {
            self.killTeamFromJson { killTeamDatabase in
                self.parsePloyCommandReRoll { ploy in
                    storage.setPloyCommandReRoll(ploy)
                }
                store.setFaction(killTeamDatabase)
                self.getHashSumDatabase { checksum in
                    self.getChecksumDatabase { databaseChecksum in
                        if checksum != databaseChecksum {
                            let updateUserKillTeam = UpdateUserKillTeam(newBase: killTeamDatabase, storage: storage)
                            updateUserKillTeam.updateBase()
                            self.saveChecksumDatabase(checksum)
                            completion()
                        } else {
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    private func killTeamFromJson(completion: @escaping ([Faction])->Void) {
        guard let path = Bundle.main.path(forResource: dataFileName, ofType: "json") else {
            print("DEBUG: KillTeams database - Incorrect File Name")
            return
        }
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
            let killTeamDatabase = try JSONDecoder().decode([Faction].self, from: jsonData as Data)
            completion(killTeamDatabase)
        } catch let error {
            print("DEBUG: KillTeams database - parse error: \(error.localizedDescription)")
        }
    }
    
//MARK: - ChecksumDatabase
    
    private func saveChecksumDatabase(_ checksum: String?) {
        UserDefaults.standard.set(checksum, forKey: keyChecksumDatabase)
    }
    
    private func getChecksumDatabase(completion: @escaping(String?)->Void) {
        let databaseId = UserDefaults.standard.string(forKey: keyChecksumDatabase)
        completion(databaseId)
    }
    
    private func getHashSumDatabase(completion: @escaping(String) -> Void) {
        guard let path = Bundle.main.path(forResource: dataFileName, ofType: "json") else {
            print("DEBUG: KillTeams database - Incorrect File Name")
            return
        }
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as Data
            completion(jsonData.md5)
        } catch let error {
            print("DEBUG: KillTeams database - parse error: \(error.localizedDescription)")
        }   
    }
    
}

extension Data {

    var md5 : String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ =  self.withUnsafeBytes { bytes in
            CC_MD5(bytes, CC_LONG(self.count), &digest)
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }

}
