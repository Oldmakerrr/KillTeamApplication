//
//  ChooseKillTeamTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseKillTeamTableViewCell: UITableViewCell {
    
    var killTeamNameLabel: UILabel?
    var factionNameLabel: UILabel?
    var killteamLogo: UIImageView?
    
    func createTitle(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leftAnchor.constraint(equalTo: killteamLogo?.rightAnchor ?? self.rightAnchor, constant: 20).isActive = true
        return label
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
