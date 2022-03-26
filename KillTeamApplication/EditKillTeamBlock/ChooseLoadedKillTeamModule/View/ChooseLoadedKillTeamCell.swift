//
//  ChooseLoadedKillTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 24.03.2022.
//

import Foundation
import UIKit

class ChooseLoadedKillTeamCell: UITableViewCell {
    
    static let identifier = "ChooseLoadedKillTeamCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
