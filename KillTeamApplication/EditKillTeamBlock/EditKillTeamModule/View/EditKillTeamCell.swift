//
//  EditKillTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamCell: UITableViewCell {

    static let identifire = "EditKillTeamCell"
    
    lazy var unitName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    lazy var closeWaepon: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var rangeWaepon: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    lazy var equipment: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(closeWaepon)
        contentView.addSubview(rangeWaepon)
        contentView.addSubview(equipment)
        contentView.addSubview(unitName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        closeWaepon.frame = CGRect(x: 30, y: 35, width: 300, height: 15)
        rangeWaepon.frame = CGRect(x: 30, y: 55, width: 300, height: 15)
        equipment.frame = CGRect(x: 30, y: 75, width: 400, height: 15)
        unitName.frame = CGRect(x: 10, y: 10, width: 300, height: 20)
    }
}
