//
//  GameStore.swift
//  KillTeamApplication
//
//  Created by Apple on 23.02.2022.
//

import Foundation

final class GameStoreMulticastDelegate<T> {
    
    private var delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func addDelegate(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func removeDelegate(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() {
            if delegate === delegateToRemove as AnyObject {
                delegates.remove(delegate)
            }
        }
    }
    
    func invoke(_ invocation: (T)->()) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
}



protocol GameStoreProtocol: AnyObject {
    var multicastDelegate: GameStoreMulticastDelegate<GameStoreDelegate> { get }
    var tacOps: [TacOp] { get }
    func parseTacOps()
    func updateGameData(gameData: GameData)
    func getGameDate() -> GameData?
}

protocol GameStoreDelegate: AnyObject {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?)
}

final class GameStore: GameStoreProtocol {
    
    var multicastDelegate = GameStoreMulticastDelegate<GameStoreDelegate>()
    
    private var gameData: GameData? {
        didSet{
            multicastDelegate.invoke({ presenter in
                presenter.didUpdate(self, gameData: gameData)
            })
        }
    }
    
    func getGameDate() -> GameData? {
        return self.gameData
    }
    
    func updateGameData(gameData: GameData) {
        self.gameData = gameData
    }
    
    var tacOps = [TacOp]()
    
    func parseTacOps() {
        let path = Bundle.main.path(forResource: "TacOps_v3", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        tacOps = try! JSONDecoder().decode([TacOp].self, from: jsonData! as Data)
    }
    
}


struct GameData {
    
    var countCommandPoint = 0
    var countVictoryPoint = 0
    var countTurningPoint = 0
    var countKillTeamAbilitiePoint: Int?
    var currentStrategicPloys = [Ploy]()
    var firstTacOp: TacOp?
    var secondTacOp: TacOp?
    var thirdTacOp: TacOp?
    var currentAbilitie: String?
    
}
