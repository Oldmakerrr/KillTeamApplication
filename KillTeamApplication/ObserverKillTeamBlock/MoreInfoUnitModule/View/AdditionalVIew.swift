//
//  AdditionalVIew.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

//MARK: - TextView

class TextView: UIStackView {
    
    private let subView = UIView()
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.applyCornerRadius()
        layer.masksToBounds = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addArrangedSubview(subView)
        subView.backgroundColor = ColorScheme.shared.theme.viewBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorScheme.shared.theme.textNormal
        label.numberOfLines = 0
        subView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: Constant.Size.Otstup.normal),
            label.topAnchor.constraint(equalTo: subView.topAnchor, constant: Constant.Size.Otstup.normal),
            label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -Constant.Size.Otstup.normal),
            label.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -Constant.Size.Otstup.normal)

        ])
    }
}

//MARK: - CharacteristicsView



class CharacteristicsView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(unit: Unit, widthSuperView: CGFloat) {
        setupSubView(firstNameCharacteristic: "M", secondNameCharacteristic: "APL", firstText: String(unit.movement), secondText: String(unit.actionPointLimit), widthSuperView: widthSuperView)
        setupSubView(firstNameCharacteristic: "GA", secondNameCharacteristic: "DF", firstText: String(unit.groupActivation), secondText: String(unit.defense), widthSuperView: widthSuperView)
        setupSubView(firstNameCharacteristic: "SV", secondNameCharacteristic: "W", firstText: "\(unit.save)+", secondText: String(unit.wounds), widthSuperView: widthSuperView)
    }
    
    private func setupSubView(firstNameCharacteristic: String,
                              secondNameCharacteristic: String,
                              firstText: String,
                              secondText: String,
                              widthSuperView: CGFloat) {
        let view = UIView()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        let firstLabel = CharacteristicLabelView()
        let secondLabel = CharacteristicLabelView()
        firstLabel.setupText(nameCharacteristic: firstNameCharacteristic, value: firstText)
        secondLabel.setupText(nameCharacteristic: secondNameCharacteristic, value: secondText)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            firstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -widthSuperView/2),
            secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthSuperView/2 + 5),
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: Constant.Size.headerHeight)
        ])
        addArrangedSubview(view)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.viewBackground
        axis = .vertical
        spacing = 15
    }
}


