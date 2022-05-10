//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CounterViewController: UIViewController, CounterViewProtocol {
    
    var presenter: CounterPresenterProtocol?
    
    let customAlert = CustomScrollAlert()
    
    let currentKillTeamView = CurrentKillTeamView()
    
    let addKillTeamButton = AddButton()

    let turningPointLabel = CounterLabel()
    
    let currentAbilitieView = ViewWithLabel()
    
    let counterLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let commandPoint = CounterPointView(title: "Command Point")
    let victoryPoint = CounterPointView(title: "Victory Point")
    var killTeamAbilitiePoint: CounterPointView?
    
    let nextTurnButton = ChangeTurnButton()
    let endGameButton = ChangeTurnButton()
    
    lazy var nextTurnButtonView = ButtonView(button: nextTurnButton, width: 100, height: 30)
    lazy var endGameButtonView = ButtonView(button: endGameButton, width: 100, height: 30)
    
    let currentPloysCollectionView = CurrentPloysCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBackgroundImage()
        setupSubView()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        currentPloysCollectionView.reloadData()
        setupAddButton()
        fillCounterStackView()
        setupTextToAbilitieView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addKillTeamButton.removeFromSuperview()
    }
    
    func showAlert(ploy: Ploy) {
        let view = PloyView()
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        customAlert.showAlert(alertView: view, targetViewController: self)
        view.setupPloy(ploy: ploy, delegate: self, viewWidth: view.weaponView.getViewWidth())
        view.setupButton(delegate: self)
    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    @objc func addKillTeam() {
        presenter?.addKillTeam()
    }
    
    @objc func buttonAction(sender: UIButton) {
        if let presenter = presenter {
            presenter.buttonAction(sender: sender)
        }
    }
    
}

extension CounterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.model.gameData.currentStrategicPloys.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentPloysCollectionViewCell.identifier, for: indexPath) as! CurrentPloysCollectionViewCell
        guard let ploy = presenter?.model.gameData.currentStrategicPloys[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.setupText(ploy: ploy)
        return cell
    }
    
}

extension CounterViewController: CurrentPloysCollectionViewDelegate {
    func didSelectCell(_ CurrentPloysCollectionView: CurrentPloysCollectionView, indexPath: IndexPath) {
        guard let ploy = presenter?.model.gameData.currentStrategicPloys[indexPath.item] else {
            return }
        showAlert(ploy: ploy)
    }
    
    
}

extension CounterViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
    
    
}

