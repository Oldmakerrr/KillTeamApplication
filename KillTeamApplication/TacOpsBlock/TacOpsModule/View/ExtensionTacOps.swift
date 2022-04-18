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
    
    func setupButton() {
        navigationItem.rightBarButtonItem = editButton
        editButton.image = UIImage(systemName: "plus")
        editButton.target = self
        editButton.action = #selector(edit)
    }
    
    func setupGoToChoosenTacOpsButton() {
        navigationItem.leftBarButtonItem = goToChoosenTacOpsButton
        goToChoosenTacOpsButton.image = UIImage(systemName: "square.and.arrow.up")
        goToChoosenTacOpsButton.target = self
        goToChoosenTacOpsButton.action = #selector(goToChoosenTacOpsView)
    }
    
//MARK: - ButtonAction
    
    @objc private func goToChoosenTacOpsView() {
        presenter?.goToChoosenTacOps()
    }
    
    @objc private func edit() {
        let editAlertController = UIAlertController()
        let changeType = UIAlertAction(title: "Change type", style: .default) { _ in
            self.changeTacOpsAlert()
            self.tacOpsCollection.reloadData()
        }
        var title = "Mix deck"
        if presenter!.model.factionDeck != nil {
            title = "Mix deck without Facton Tac Ops"
        }
        let mixDeckAction = UIAlertAction(title: title, style: .default) { _ in
            self.presenter?.mixDeck()
            self.tacOpsCollection.reloadData()
        }
        let mixDeckWithSpecialTacOpsAction = UIAlertAction(title: "Mix deck with Faction Tac Ops", style: .default) { _ in
            self.presenter?.mixDeckWithSpecialTacOps()
            self.tacOpsCollection.reloadData()
        }
        let cancle = UIAlertAction(title: "Cancle", style: .cancel) { _ in }
        editAlertController.addAction(changeType)
        editAlertController.addAction(mixDeckAction)
        if presenter!.model.factionDeck != nil {
            editAlertController.addAction(mixDeckWithSpecialTacOpsAction)
        }
        editAlertController.addAction(cancle)
        present(editAlertController, animated: true, completion: nil)
    }
    
//MARK: - Show/Dismiss Alert
    
    func showAlert(tacOp: TacOp) {
        moreInfoTacOpView = TacOpView()
        moreInfoTacOpView.layer.applyCornerRadius()
        moreInfoTacOpView.layer.masksToBounds = true
        moreInfoTacOpView.delegate = self
        moreInfoTacOpView.setupText(tacOp: tacOp, delegate: self)
        moreInfoTacOpView.setupButton()
        customAlert.showAlert(alertView: moreInfoTacOpView, targetViewController: self)
    }
    
    func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    
    
//MARK: - EditTacOpsDeck
    
    private func changeTacOpsAlert() {
        let alertController = UIAlertController(title: nil, message: "Choose tacops type", preferredStyle: .actionSheet)
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
