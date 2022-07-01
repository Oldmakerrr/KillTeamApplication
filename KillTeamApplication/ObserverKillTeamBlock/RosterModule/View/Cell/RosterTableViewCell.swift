//
//  RosterTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 12.04.2022.
//

import Foundation
import UIKit

class RosterTableViewCell: EditKillTeamCell {
    
    private func unitStatusImage (currentWounds: Int, maxWounds: Int) -> UIImage? {
        if currentWounds == 0 {
            changeBackgroundAlpha()
            return UIImage(named: "Skull")
        } else if currentWounds < sdf(int: maxWounds) {
            return UIImage(named: "Damage")
        } else {
            return nil
        }
    }
    
    override func addNameLabel(unit: Unit) -> UIView {
        //guard let currentWounds = unit.currentWounds  else { return UIView() }
        let header = HeaderImageView()
        let image = unitStatusImage(currentWounds: unit.currentWounds, maxWounds: unit.wounds)
        header.setupText(name: unit.customName ?? unit.name, cost: "W = \(unit.currentWounds)", image: image)
        return header
    }
    
    private func sdf(int: Int) -> Int {
        var int = int
        if int % 2 != 0 {
            int += 1
            int /= 2
            return int
        }
        return int/2
    }
    
    
}
