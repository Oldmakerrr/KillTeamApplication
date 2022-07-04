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

final class ParseJSON {
    
    private let databaseQueue = DispatchQueue.global(qos: .utility)
    
    private let tacOpsFileName = "TacOps_v3"
    private let dataFileName = "AllFaction_TEST"
    private let keyChecksumDatabase = "ChecksumDatabase"
    
    func parseTacOps(completion: @escaping (([TacOp]) -> Void)) {
        databaseQueue.async {
            let path = Bundle.main.path(forResource: self.tacOpsFileName, ofType: "json")
            let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
            let tacOps = try! JSONDecoder().decode([TacOp].self, from: jsonData! as Data)
            DispatchQueue.main.async {
                completion(tacOps)
            }
        }
    }
    
    func parseJson(store: StoreProtocol, storage: StorageProtocol, completion: @escaping ()->Void) {
        databaseQueue.async {
            self.killTeamFromJson { killTeamDatabase in
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
        let path = Bundle.main.path(forResource: dataFileName, ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        let killTeamDatabase = try! JSONDecoder().decode([Faction].self, from: jsonData! as Data)
        completion(killTeamDatabase)
    }
    
//MARK: - ChecksumDatabase
    
    private func saveChecksumDatabase(_ checksum: String?) {
        UserDefaults.standard.set(checksum, forKey: keyChecksumDatabase)
    }
    
    private func getChecksumDatabase(completion: @escaping(String?)->Void) {
        let databaseId = UserDefaults.standard.string(forKey: keyChecksumDatabase)
        completion(databaseId)
    }
    
    private func getHashSumDatabase(completion: @escaping(String?) -> Void) {
        let path = Bundle.main.path(forResource: dataFileName, ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        if let jsonData = jsonData as? Data {
            completion(jsonData.md5)
        } else {
            completion(nil)
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
