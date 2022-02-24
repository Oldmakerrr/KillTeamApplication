//
//  PloyMoreInfoView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.02.2022.
//

import Foundation
import UIKit

class PloyMoreInfoView: UIStackView {
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let coastLabel = UILabel()
    let button = UIButton()
    
    static let identifier = "PloysTableViewCell"

    private let header = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingview()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


//MARK: - MethodsView
    
    private func settingview() {
        layer.masksToBounds = true
        layer.cornerRadius = 12
        backgroundColor = .systemGray2
        addHeader()
        addHeaderLabel()
        addDescriptionLabel()
        setupButton()
    }

     private func addHeader() {
         addSubview(header)
         header.translatesAutoresizingMaskIntoConstraints = false
         header.backgroundColor = .orange
         header.topAnchor.constraint(equalTo: topAnchor).isActive = true
         header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
         header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
         addSubview(descriptionLabel)
         descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
         descriptionLabel.font = UIFont.systemFont(ofSize: 18)
         descriptionLabel.numberOfLines = 0
         descriptionLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15).isActive = true
         descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
         descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        // descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
     }
    
    private func setupButton() {
        addSubview(button)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
