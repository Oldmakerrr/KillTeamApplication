//
//  AllegoryView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class AllegoryView: UIView {
    
    let nameLabel = BigLabel()
    let performanceLabel = BoldTextLabel()
    let accoladeLabel = BoldTextLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
        nameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(allegory: VoidDancerTroupeAbilitie.Allegory) {
        nameLabel.text = allegory.name
        performanceLabel.addText(bold: "Performance", normal: allegory.performance)
        accoladeLabel.addText(bold: "Accolade", normal: allegory.accolade)
    }
    
    private func addConstraints() {
        addSubview(nameLabel)
        addSubview(performanceLabel)
        addSubview(accoladeLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
        NSLayoutConstraint.activate([
            performanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constant.Size.Otstup.small),
            performanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            performanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            performanceLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
        NSLayoutConstraint.activate([
            accoladeLabel.topAnchor.constraint(equalTo: performanceLabel.bottomAnchor, constant: Constant.Size.Otstup.small),
            accoladeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            accoladeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            accoladeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
    }
}
