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
     
     let plusButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .gray
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "plus"), for: .normal)
         button.imageView?.tintColor = .systemOrange
         button.layer.masksToBounds = true
         button.layer.cornerRadius = 10
         button.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
         return button
     }()
     
     lazy var countSelectedFireTeamLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.font = UIFont.systemFont(ofSize: 20)
         label.text = "\(countFireTeam)"
         return label
     }()
     
     let minusButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = .gray
         button.setImage(UIImage(systemName: "minus"), for: .normal)
         button.imageView?.tintColor = .systemOrange
         button.layer.masksToBounds = true
         button.layer.cornerRadius = 10
         button.addTarget(self, action: #selector(removeFireTeam), for: .touchUpInside)
         return button
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray3
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
     func didUpdate(_ store: Store, killTeam: KillTeam) {
         if let key = killTeam.counterFT?[fireTeam!.name] {
             countFireTeam = key
         }
     }
 }

 

