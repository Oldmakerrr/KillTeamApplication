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
    
    let label = NormalLabel()
    
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
        subView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: Constant.Size.EdgeInsets.normal),
            label.topAnchor.constraint(equalTo: subView.topAnchor, constant: Constant.Size.EdgeInsets.normal),
            label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal),
            label.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal)

        ])
    }
}

//MARK: - CharacteristicsView

class CharacteristicsViewWithoutImage: UIStackView {
    
    private let characteristicValue: [[String]]
    private let characteristicName = [["M","APL","GA"],["DF","SV","W"]]
    
    init(unit: Unit) {
        var array = [[String]]()
        var firstArray = [String]()
        var secondArray = [String]()
        firstArray.append("\(unit.movement * 2)'")
        firstArray.append(String(unit.actionPointLimit))
        firstArray.append(String(unit.groupActivation))
        secondArray.append(String(unit.defense))
        secondArray.append("\(unit.save)+")
        secondArray.append(String(unit.wounds))
        array.append(firstArray)
        array.append(secondArray)
        characteristicValue = array
        super.init(frame: .zero)
        configure()
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addArrangedSubview(UIView())
        for (index, texts) in characteristicValue.enumerated() {
            setupSubView(texts:( texts, characteristicName[index]))
        }
        addArrangedSubview(UIView())
    }
    
    private func configure() {
        axis = .vertical
        spacing = 10
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.applyCornerRadius()
        layer.masksToBounds = true
    }
    
    private func setupSubView(texts: ([String],[String])) {
        let stackView = UIStackView()
        stackView.backgroundColor = ColorScheme.shared.theme.subViewBackground
        stackView.alignment = .center
        stackView.spacing = 16
        for (index, text) in texts.0.enumerated() {
            let label = HeaderLabel()
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.text = "\(texts.1[index]) = \(text)"
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        addArrangedSubview(stackView)
    }
    
}

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
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.025),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -widthSuperView/2 - Constant.Size.screenWidth * 0.013),
            secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthSuperView/2 + Constant.Size.screenWidth * 0.013),
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.025),
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

//MARK: CharacteristicLabelView

class CharacteristicLabelView: UIView {
    
    private let nameCharacteristicLabel = HeaderLabel()
    private let equatableLabel = HeaderLabel()
    private let valueLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(nameCharacteristic: String, value: String) {
        nameCharacteristicLabel.text = nameCharacteristic
        valueLabel.text = value
    }
    
    private func setupLabels() {
        nameCharacteristicLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045)
        equatableLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045)
        valueLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045) //0.053
        addSubview(nameCharacteristicLabel)
        addSubview(equatableLabel)
        addSubview(valueLabel)
        nameCharacteristicLabel.numberOfLines = 1
        nameCharacteristicLabel.textAlignment = .center
        nameCharacteristicLabel.adjustsFontSizeToFitWidth = true
        equatableLabel.numberOfLines = 1
        equatableLabel.textAlignment = .center
        equatableLabel.adjustsFontSizeToFitWidth = true
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        equatableLabel.text = "="
        NSLayoutConstraint.activate([
            nameCharacteristicLabel.topAnchor.constraint(equalTo: topAnchor),
            nameCharacteristicLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameCharacteristicLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameCharacteristicLabel.trailingAnchor.constraint(equalTo: equatableLabel.leadingAnchor),
            nameCharacteristicLabel.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.085)
        ])
        
        NSLayoutConstraint.activate([
            equatableLabel.topAnchor.constraint(equalTo: topAnchor),
            equatableLabel.leadingAnchor.constraint(equalTo: nameCharacteristicLabel.trailingAnchor),
            equatableLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            equatableLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: equatableLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.073)
        ])

    }
    
}
