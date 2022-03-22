//
//  AddFireTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol AddFireTeamCellDelegate: AnyObject {
    func didCompletePlusFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam)
    func didCompleteMinusFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam)
}

class AddFireTeamCell: UITableViewCell {

    static let identifier = "AddFireTeamCell"
    
    weak var delegate: AddFireTeamCellDelegate?
    
    var fireTeam: FireTeam?
    
    var countFireTeam = 0 {
        didSet {
            countSelectedFireTeamLabel.text = "\(countFireTeam)"
        }
    }
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(UIImage(systemName: "plus.app.fill"), for: .normal)
        button.imageView?.tintColor = .orange
        button.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
        return button
    }()
    
    lazy var countSelectedFireTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "\(countFireTeam)"
        return label
    }()
    
    lazy var minusButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            button.setImage(UIImage(systemName: "minus.square.fill"), for: .normal)
            button.imageView?.tintColor = .orange
            button.addTarget(self, action: #selector(removeFireTeam), for: .touchUpInside)
            return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray3
        contentView.addSubview(plusButton)
        contentView.addSubview(countSelectedFireTeamLabel)
        contentView.addSubview(minusButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.frame = CGRect(x: contentView.frame.size.width - 50,
                                  y: 5,
                                  width: contentView.frame.size.height - 10,
                                  height: contentView.frame.size.height - 10)
        
        countSelectedFireTeamLabel.frame = CGRect(x: Int(contentView.frame.size.width) - 75,
                                                  y: 10,
                                                  width: 20,
                                                  height: 20)
        
        minusButton.frame = CGRect(x: contentView.frame.size.width - 120,
                                   y: 5,
                                   width: contentView.frame.size.height - 10,
                                   height: contentView.frame.size.height - 10)
    }
    
    @objc func addFireTeam() {
        delegate?.didCompletePlusFireTeam(self, fireTeam: fireTeam!)
    }
    
    @objc func removeFireTeam() {
        delegate?.didCompleteMinusFireTeam(self, fireTeam: fireTeam!)
    }
}

extension AddFireTeamCell: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        if let key = killTeam?.counterFT?[fireTeam!.name] {
            countFireTeam = key
        }
    }
}
