//
//  PloysTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class PloysTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let coastLabel = UILabel()
    
    static let identifier = "PloysTableViewCell"

    private let header = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//MARK: - MethodsView
    
    private func settingview() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGray2
        backgroundColor = .black
        addHeader()
        addHeaderLabel()
        addDescriptionLabel()
    }

     private func addHeader() {
         contentView.addSubview(header)
         header.translatesAutoresizingMaskIntoConstraints = false
         header.backgroundColor = .orange
         header.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
         header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
         header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
         header.heightAnchor.constraint(equalToConstant: 40).isActive = true
     }
     
     private func addHeaderLabel() {
         header.addSubview(nameLabel)
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
         nameLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
         nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
         
         header.addSubview(coastLabel)
         coastLabel.translatesAutoresizingMaskIntoConstraints = false
         coastLabel.font = UIFont.boldSystemFont(ofSize: 20)
         coastLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
         coastLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -15).isActive = true
     }
     
     private func addDescriptionLabel() {
         contentView.addSubview(descriptionLabel)
         descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
         descriptionLabel.font = UIFont.systemFont(ofSize: 18)
         descriptionLabel.numberOfLines = 0
         descriptionLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15).isActive = true
         descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
         descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
         descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
     }
     
}
