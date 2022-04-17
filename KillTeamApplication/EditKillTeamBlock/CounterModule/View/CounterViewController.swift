//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CounterViewController: UIViewController, CounterViewProtocol {
    
    var presenter: CounterPresenterProtocol?
    
    let customAlert = CustomAlert()
    let currentKillTeamView = CurrentKillTeamView()
    
    let addKillTeamButton = AddButton()
    
    let currentStrategicPloyLabel = CounterLabel()

    let turningPointLabel = CounterLabel()
    let commandPointLabel = CounterLabel()
    let victoryPointLabel = CounterLabel()
    
    let plusCommandPoint = ChangePointButton()
    let minusCommandPoint = ChangePointButton()
    let plusVictoryPoint = ChangePointButton()
    let minusVictoryPoint = ChangePointButton()
    
    let nextTurnButton = ChangeTurnButton()
    let endGameButton = ChangeTurnButton()
    
    let currentPloysCollectionView = CurrentPloysCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBackgroundImage()
        setupSubView()
        enableButtons()
        currentPloysCollectionView.dataSource = self
        currentPloysCollectionView.selectCellDelegate = self
        currentKillTeamView.delegate = presenter as? CurrentKillTeamViewProtocol
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        currentPloysCollectionView.reloadData()
        setupAddButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addKillTeamButton.removeFromSuperview()
    }
    
    func showAlert(ploy: Ploy) {
        let view = PloyView()
        view.setupPloy(ploy: ploy, delegate: self)
        view.setupButton(delegate: self)
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        customAlert.showAlert(alertView: view, targetView: self)
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

extension CounterViewController: CurrentPloysCollectionViewProtocol {
    func didSelectCell(_ CurrentPloysCollectionView: CurrentPloysCollectionView, indexPath: IndexPath) {
        guard let ploy = presenter?.model.gameData.currentStrategicPloys[indexPath.item] else {
            return }
        showAlert(ploy: ploy)
    }
    
    
}

extension CounterViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        print("adfdf")
    }
    
    
    
}

