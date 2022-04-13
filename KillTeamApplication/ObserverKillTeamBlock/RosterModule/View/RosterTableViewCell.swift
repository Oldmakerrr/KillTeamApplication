//
//  RosterTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 12.04.2022.
//

import Foundation
import UIKit

class RosterTableViewCell: EditKillTeamCell {
    
    static let identifier = "RosterTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addNameLabel(unit: Unit) -> UIView {
        let header = HeaderViewWithInt()
        if let currentWounds = unit.currentWounds {
            header.setupText(name: unit.name, cost: "W = \(currentWounds)")
             if currentWounds == 0 {
                 changeBackgroundAlpha()
             }
         }
        return header
    }
    
    func setupInjuredImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Damage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
}
