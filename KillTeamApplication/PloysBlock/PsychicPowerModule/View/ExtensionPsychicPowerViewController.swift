//
//  ExtensionPsychicPowerViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 25.04.2022.
//

import Foundation
import  UIKit

extension PsychicPowerViewController {
    
    func setupPsychicPower() {
        if let psychicPowerDescription = presenter?.model.psychicPowerDescription {
            setupDescriptionView(psychicPowerDescription: psychicPowerDescription)
        }
        if let psychicPowers = presenter?.model.PsychicPowers {
            setupPsychicPowersView(psychicPowers: psychicPowers)
        }
        if let typesOfPsychicPower = presenter?.model.typesOfPsychicPower {
            if let lastChoosenPsychicDisciplines = presenter?.getLastChoosenPsychicDisciplines() {
                setupPsychicDisciplines(type: lastChoosenPsychicDisciplines)
            } else {
                guard let type = typesOfPsychicPower.keys.first else { return }
                setupPsychicDisciplines(type: type)
            }
        }
    }
    
    func setupRightBarButtonItems() {
        /*
        let infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                        style: .done,
                                        target: self,
                                        action: #selector(showAlert))
        navigationItem.rightBarButtonItems = [infoBarButton]
        */
        guard let typesOfPsychicPower = presenter?.model.typesOfPsychicPower else { return }
        if !typesOfPsychicPower.isEmpty {
            let changePsychicDisciplinesBarButton = UIBarButtonItem(image: UIImage(named: "change"),
                                                                    style: .done,
                                                                    target: self,
                                                                    action: #selector(changeTypeOfPsychicPower))
            navigationItem.rightBarButtonItems = [changePsychicDisciplinesBarButton]
        }
    }
    
    /*
    @objc private func showAlert() {
        guard let psychicPowerDescription = presenter?.model.psychicPowerDescription else { return }
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            return stackView
        }()
        setupDescriptionView(psychicPowerDescription: psychicPowerDescription, stackView: stackView)
        customAlert.showAlert(alertView: stackView, targetViewController: self)
    }
     */
 
    @objc private func changeTypeOfPsychicPower() {
        guard let typesOfPsychicPower = presenter?.model.typesOfPsychicPower.keys else { return }
        let alert = UIAlertController(title: "Choose following psychic disciplines", message: nil, preferredStyle: .actionSheet)
        for type in typesOfPsychicPower {
            let action = UIAlertAction(title: type, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.setupPsychicDisciplines(type: type)
                self.presenter?.updateLastChoosenPsychicDisciplines(psychicDisciplines: type)
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupPsychicDisciplines(type: String) {
        guard let psychicPowers = presenter?.model.typesOfPsychicPower[type] else { return }
        setupPsychicPowersView(psychicPowers: psychicPowers)
    }
    
    private func clearPsychicPowerView() {
        currentPsychicPowerView.forEach { view in
            view.removeFromSuperview()
        }
        currentPsychicPowerView.removeAll()
    }
    
    private func setupPsychicPowersView(psychicPowers: [PsychicPower]) {
        clearPsychicPowerView()
        psychicPowers.forEach { psychicPower in
            let backgroundView = UIView()
            let view = PsychicPowerView()
            view.layer.applyCornerRadius()
            view.layer.masksToBounds = true
            backgroundView.addView(top: Constant.Size.Otstup.small,
                                   bottom: Constant.Size.Otstup.small,
                                   leading: Constant.Size.Otstup.small,
                                   trailing: Constant.Size.Otstup.small,
                                   view: backgroundView,
                                   subView: view)
            view.setupText(psychicPower: psychicPower, delegate: self)
            currentPsychicPowerView.append(backgroundView)
            contentView.addArrangedSubview(backgroundView)
        }
    }
    
    private func setupDescriptionView(psychicPowerDescription: [String]) {
        let backgroundView = UIView()
        let view = UIStackView()
        view.layer.applyCornerRadius()
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        view.addSubTextPointView(subText: psychicPowerDescription)
        view.addView(view: backgroundView, subView: view)
        contentView.addArrangedSubview(backgroundView)
        /*
        for text in psychicPowerDescription {
            let view = UIView()
            view.backgroundColor = ColorScheme.shared.theme.viewBackground
            let label = NormalLabel()
            label.text = text
            view.addView(view: view, subView: label)
            contentView.addArrangedSubview(view)
        }
        */
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
}
