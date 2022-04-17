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
 
 class AddFireTeamCell: UITableViewCell, ReusableView {

    static var identifier: String {
        String(describing: self)
    }
     
     weak var delegate: AddFireTeamCellDelegate?
     
     var fireTeam: FireTeam?
     
     var countFireTeam = 0 {
         didSet {
             countSelectedFireTeamLabel.text = "\(countFireTeam)"
         }
     }
    
    lazy var countSelectedFireTeamLabel: NormalLabel = {
        let label = NormalLabel()
        label.textAlignment = .center
        label.text = "\(countFireTeam)"
        return label
    }()
    
    let plusButton: AddFireTeamButton = {
        let button = AddFireTeamButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.tintColor = ColorScheme.shared.theme.selectedView
        button.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
        return button
    }()
    
    let minusButton: AddFireTeamButton = {
        let button = AddFireTeamButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.imageView?.tintColor = ColorScheme.shared.theme.selectedView
        button.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
        return button
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        plusButton.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(removeFireTeam), for: .touchUpInside)
        setupConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setupConstraints() {
         contentView.addSubview(plusButton)
         NSLayoutConstraint.activate([
             plusButton.widthAnchor.constraint(equalToConstant: 40),
             plusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
             plusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
             plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
         ])

         contentView.addSubview(minusButton)
         NSLayoutConstraint.activate([
             minusButton.topAnchor.constraint(equalTo: plusButton.topAnchor),
             minusButton.bottomAnchor.constraint(equalTo: plusButton.bottomAnchor),
             minusButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -50),
             minusButton.widthAnchor.constraint(equalTo: plusButton.widthAnchor)
         ])
         
         contentView.addSubview(countSelectedFireTeamLabel)
         NSLayoutConstraint.activate([
             countSelectedFireTeamLabel.topAnchor.constraint(equalTo: plusButton.topAnchor),
             countSelectedFireTeamLabel.bottomAnchor.constraint(equalTo: plusButton.bottomAnchor),
             countSelectedFireTeamLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
             countSelectedFireTeamLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor)
         ])
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
        guard let killTeam = killTeam else { return }
        if let key = killTeam.counterFT?[fireTeam!.name] {
             countFireTeam = key
         }
     }
 }


class AddFireTeamButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.buttonBackground
        layer.masksToBounds = true
        layer.cornerRadius = Constant.Size.cornerRadius
        layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
        layer.borderWidth = Constant.Size.borderWidht
    }
    
}
 

