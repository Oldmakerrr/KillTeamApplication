//
//  ExtensionTacOps.swift
//  KillTeamApplication
//
//  Created by Apple on 15.04.2022.
//

import Foundation
import UIKit

extension TacOpsViewController {
    
    func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
//MARK: - SetupView
    
    func setupTacOpsCollection() {
        view.addSubview(tacOpsCollection)
        tacOpsCollection.dataSource = self
        tacOpsCollection.delegate = self
        tacOpsCollection.translatesAutoresizingMaskIntoConstraints = false
        tacOpsCollection.register(TacOpsCollectionCell.self, forCellWithReuseIdentifier: TacOpsCollectionCell.identifier)
        NSLayoutConstraint.activate([
            tacOpsCollection.topAnchor.constraint(equalTo: view.topAnchor),
            tacOpsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tacOpsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tacOpsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupRightBarButton() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        changeTacOpsTypeButton.addTarget(self, action: #selector(changeTacOpsType), for: .touchUpInside)
        changeTacOpsTypeButton.setBackgroundImage(UIImage(named: "change")?.withRenderingMode(.alwaysTemplate), for: .normal)
        changeTacOpsTypeButton.imageView?.contentMode = .scaleAspectFit
        changeTacOpsTypeButton.translatesAutoresizingMaskIntoConstraints = false
        
        mixDeckButton.addTarget(self, action: #selector(mixDeck), for: .touchUpInside)
        mixDeckButton.setBackgroundImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        mixDeckButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.addSubview(changeTacOpsTypeButton)
        navigationBar.addSubview(mixDeckButton)
        
        NSLayoutConstraint.activate([
            changeTacOpsTypeButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            changeTacOpsTypeButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -Constant.Size.EdgeInsets.large),
            changeTacOpsTypeButton.heightAnchor.constraint(equalToConstant: navigationBar.bounds.size.height-10),
            changeTacOpsTypeButton.widthAnchor.constraint(equalTo: changeTacOpsTypeButton.heightAnchor),
            
            mixDeckButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            mixDeckButton.trailingAnchor.constraint(equalTo: changeTacOpsTypeButton.leadingAnchor, constant: -Constant.Size.EdgeInsets.normal),
            mixDeckButton.heightAnchor.constraint(equalToConstant: navigationBar.bounds.size.height-10),
            mixDeckButton.widthAnchor.constraint(equalTo: mixDeckButton.heightAnchor, constant: 4)
        ])
    }
    
    @objc private func changeTacOpsType() {
        self.changeTacOpsAlert()
        self.tacOpsCollection.reloadData()
    }
    
    func setupGoToChoosenTacOpsButton() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        goToChoosenTacOpsButton.addTarget(self, action: #selector(goToChoosenTacOpsView), for: .touchUpInside)
        goToChoosenTacOpsButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle.portrait.fill"), for: .normal)
        goToChoosenTacOpsButton.translatesAutoresizingMaskIntoConstraints = false
        goToChoosenTacOpsButton.setTitleColor(UIColor.gray, for: .disabled)
        navigationBar.addSubview(goToChoosenTacOpsButton)
        NSLayoutConstraint.activate([
            goToChoosenTacOpsButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            goToChoosenTacOpsButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: Constant.Size.EdgeInsets.large),
            goToChoosenTacOpsButton.heightAnchor.constraint(equalToConstant: navigationBar.bounds.size.height-10),
            goToChoosenTacOpsButton.widthAnchor.constraint(equalTo: goToChoosenTacOpsButton.heightAnchor, constant: -5)
        ])
    }
    
//MARK: - ButtonAction
    
    @objc private func goToChoosenTacOpsView() {
        presenter?.goToChoosenTacOps()
    }
    
    @objc private func mixDeck() {
        guard let presenter = presenter else { return }
        if presenter.model.factionDeck == nil {
            self.presenter?.mixDeck()
            self.tacOpsCollection.reloadData()
        } else {
            presentAlert()
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actoinWithFactionTacOp = UIAlertAction(title: "Mix deck with Faction Tac Ops", style: .default) { _ in
            self.presenter?.mixDeckWithSpecialTacOps()
            self.tacOpsCollection.reloadData()
        }
        let actionWithoutFactionTacOp = UIAlertAction(title: "Mix deck without Faction Tac Ops", style: .default) { _ in
            self.presenter?.mixDeck()
            self.tacOpsCollection.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actoinWithFactionTacOp)
        alert.addAction(actionWithoutFactionTacOp)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
//MARK: - Show/Dismiss Alert
    
    func showAlert(tacOp: TacOp) {
        moreInfoTacOpView = TacOpView()
        moreInfoTacOpView.layer.applyCornerRadius()
        moreInfoTacOpView.layer.masksToBounds = true
        moreInfoTacOpView.delegate = self
        moreInfoTacOpView.setHeader(title: tacOp.name)
        moreInfoTacOpView.setupText(tacOp: tacOp, delegate: self)
        moreInfoTacOpView.setupButton()
        customAlert.showAlert(alertView: moreInfoTacOpView, targetViewController: self)
    }
    
    func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    
//MARK: - EditTacOpsDeck
    
    private func changeTacOpsAlert() {
        let alertController = UIAlertController(title: "Choose Tac Ops type", message: nil, preferredStyle: .actionSheet)
        let seekAndDestroy = UIAlertAction(title: "Seek & Destroy", style: .default) {[self] _ in
            presenter?.pickTacOps(sender: .seekAndDestroy, collectionView: tacOpsCollection)
            navigationItem.title = "Seek & Destroy"
        }
        let security = UIAlertAction(title: "Security", style: .default) {[self] _ in
            presenter?.pickTacOps(sender: .security, collectionView: tacOpsCollection)
            navigationItem.title = "Security"
        }
        let infiltration = UIAlertAction(title: "Infiltration", style: .default) {[self] _ in
            presenter?.pickTacOps(sender: .infiltration, collectionView: tacOpsCollection)
            navigationItem.title = "Infiltration"
        }
        let recon = UIAlertAction(title: "Recon", style: .default) {[self] _ in
            presenter?.pickTacOps(sender: .recon, collectionView: tacOpsCollection)
            navigationItem.title = "Recon"
        }
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alertController.addAction(seekAndDestroy)
        alertController.addAction(security)
        alertController.addAction(infiltration)
        alertController.addAction(recon)
        alertController.addAction(cancle)
        present(alertController, animated: true, completion: nil)
    }
    
}
