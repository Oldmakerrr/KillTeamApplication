//
//  ExtensionTacOps.swift
//  KillTeamApplication
//
//  Created by Apple on 15.04.2022.
//

import Foundation
import UIKit

extension TacOpsViewController {
    
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
        let changeTacOpsTypeButton = UIBarButtonItem(image: UIImage(named: "change"),
                                                     style: .done,
                                                     target: self,
                                                     action: #selector(changeTacOpsType))
        let mixDeckButton = UIBarButtonItem(image: UIImage(systemName: "arrow.2.circlepath"),
                                            style: .done,
                                            target: self,
                                            action: #selector(mixDeck))
        navigationItem.rightBarButtonItems = [mixDeckButton, changeTacOpsTypeButton]
    }
    
    @objc private func changeTacOpsType() {
        self.changeTacOpsAlert()
        self.tacOpsCollection.reloadData()
    }
    
    func setupGoToChoosenTacOpsButton() {
        navigationItem.leftBarButtonItem = goToChoosenTacOpsButton
        goToChoosenTacOpsButton.image = UIImage(systemName: "checkmark.rectangle.portrait.fill")
        goToChoosenTacOpsButton.target = self
        goToChoosenTacOpsButton.action = #selector(goToChoosenTacOpsView)
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
        let actionWithoutFactionTacOp = UIAlertAction(title: "Mix deck without Facton Tac Ops", style: .default) { _ in
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
