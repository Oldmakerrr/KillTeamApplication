//
//  PloysTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class PloysTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let costLabel = UILabel()
    let descriptionLabel = UILabel()
    let abilitieLabel = UILabel()
    
    let ployView = PloyMoreInfoView()
    
    var backgroundStackView = UIStackView()
    let headerView = UIView()
    let descriptionView = UIView()
    var subLabels: [UILabel] = []
    let subLabelsView = UIView()
    let unitUniqueActionView = UnitUniqueAtionView()
    let abilitiesView = UIView()
    
    static let identifier = "PloysTableViewCell"

    private let header = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingview()
        contentView.addSubview(ployView)
        /*
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.5
        ployView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: ployView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: ployView.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: ployView.bottomAnchor, constant: 20)
        ])
         */
        ployView.translatesAutoresizingMaskIntoConstraints = false
        ployView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        ployView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ployView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ployView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        ployView.button.removeFromSuperview()
        
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
        backgroundStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStackView.backgroundColor = .systemGray2
        backgroundStackView.axis = .vertical
    }

    
    func addHeader(name: String, cost: String) {
        headerView.backgroundColor = .orange
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.text = name
        nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15).isActive = true
        headerView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.font = UIFont.boldSystemFont(ofSize: 20)
        costLabel.text = cost
        costLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15).isActive = true
        backgroundStackView.addArrangedSubview(headerView)
    }
    
    func addDescriptionLabel(description: String) {
        descriptionView.backgroundColor = .systemGray2
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = description
        descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10).isActive = true
        backgroundStackView.addArrangedSubview(descriptionView)
        }
   
    func addSubText(subText: [String]) {
        for (index, text) in subText.enumerated() {
            subLabelsView.translatesAutoresizingMaskIntoConstraints = false
            subLabelsView.backgroundColor = .systemGray2
            if index == 0 {
                let label = UILabel()
                subLabels.append(label)
                subLabels[index].translatesAutoresizingMaskIntoConstraints = false
                subLabels[index].numberOfLines = 0
                subLabels[index].font = UIFont.systemFont(ofSize: 18)
                subLabels[index].text = text
                subLabelsView.addSubview(label)
                subLabels[index].topAnchor.constraint(equalTo: subLabelsView.topAnchor, constant: 10).isActive = true
                subLabels[index].leadingAnchor.constraint(equalTo: subLabelsView.leadingAnchor, constant: 20).isActive = true
                subLabels[index].trailingAnchor.constraint(equalTo: subLabelsView.trailingAnchor, constant: -10).isActive = true
                if subText.count == 1 {
                    subLabels[index].bottomAnchor.constraint(equalTo: subLabelsView.bottomAnchor, constant: -10).isActive = true
                }
                
            } else {
                let label = UILabel()
                subLabels.append(label)
                subLabels[index].translatesAutoresizingMaskIntoConstraints = false
                subLabels[index].numberOfLines = 0
                subLabels[index].font = UIFont.systemFont(ofSize: 18)
                subLabels[index].text = text
                subLabelsView.addSubview(label)
                subLabels[index].topAnchor.constraint(equalTo: subLabels[index-1].bottomAnchor, constant: 10).isActive = true
                subLabels[index].leadingAnchor.constraint(equalTo: subLabelsView.leadingAnchor, constant: 20).isActive = true
                subLabels[index].trailingAnchor.constraint(equalTo: subLabelsView.trailingAnchor, constant: -10).isActive = true
                if subText.count == index+1 {
                    subLabels[index].bottomAnchor.constraint(equalTo: subLabelsView.bottomAnchor, constant: -10).isActive = true
                }
                
            }
            backgroundStackView.addArrangedSubview(subLabelsView)
       }
   }
   
    func addUnitUniqueActions(action: UnitUniqueActions) {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        unitUniqueActionView.backgroundColor = .systemGray4
        unitUniqueActionView.layer.borderWidth = 2
        unitUniqueActionView.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
        view.addSubview(unitUniqueActionView)
        unitUniqueActionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        unitUniqueActionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        unitUniqueActionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        unitUniqueActionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        unitUniqueActionView.setupText(action: action)
        backgroundStackView.addArrangedSubview(view)
        
   }
   
    func addPassiveAbilitie(abilitie: UnitAbilities) {
        abilitiesView.backgroundColor = .systemGray2
        abilitiesView.translatesAutoresizingMaskIntoConstraints = false
        abilitieLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitieLabel.numberOfLines = 0
        abilitiesView.addSubview(abilitieLabel)
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let text = NSMutableAttributedString(string: abilitie.name, attributes: attributBold)
        let description = NSAttributedString(string: ": \(abilitie.description)")
        text.append(description)
        abilitieLabel.attributedText = text
        backgroundStackView.addArrangedSubview(abilitiesView)
   }
    
    func setupBackgroundStackView() {
        contentView.addSubview(backgroundStackView)
        backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
