//
//  ExtensionTacOpsViewController.swift
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
        let mixDeckAction = UIAlertAction(title: "Mix deck", style: .default) { _ in
            self.presenter?.mixDeck()
            self.clearChoosenTacOps()
            self.tacOpsCollection.reloadData()
        }
        
        let mixDeckWithSpecialTacOpsAction = UIAlertAction(title: "Mix deck with Special Tac Ops", style: .default) { _ in
            self.presenter?.mixDeckWithSpecialTacOps()
            self.clearChoosenTacOps()
            self.tacOpsCollection.reloadData()
        }
        let cancle = UIAlertAction(title: "Cancle", style: .cancel) { _ in }
        editAlertController.addAction(changeType)
        editAlertController.addAction(mixDeckAction)
        if presenter!.model.tacOpsKillTeam != nil {
            editAlertController.addAction(mixDeckWithSpecialTacOpsAction)
        }
        editAlertController.addAction(cancle)
        present(editAlertController, animated: true, completion: nil)
    }
    
//MARK: - Show/Dismiss Alert
    
    func showAlert(tacOp: TacOps) {
        moreInfoTacOpView = MoreInfoTacOp()
        moreInfoTacOpView.layer.applyCornerRadius()
        moreInfoTacOpView.layer.masksToBounds = true
        moreInfoTacOpView.delegate = self
        moreInfoTacOpView.setupText(tacOp: tacOp, delegate: self)
        customAlert.showAlert(alertView: moreInfoTacOpView, targetView: self)
    }
    
    func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    private func clearChoosenTacOps() {
        for cell in self.tacOpsCollection.visibleCells {
            cell.contentView.backgroundColor = .systemGray2
        }
        presenter?.model.gameData.firstTacOp = nil
        presenter?.model.gameData.secondTacOp = nil
        presenter?.model.gameData.thirdTacOp = nil
    }
    
//MARK: - EditTacOpsDeck
    
    private func changeTacOpsAlert() {
        let alertController = UIAlertController(title: nil, message: "Choose tacops type", preferredStyle: .alert)
        let seekAndDestroy = UIAlertAction(title: "Seek & Destroy", style: .default) { _ in
            self.presenter?.pickTacOps(sender: .seekandDestroy)
            self.clearChoosenTacOps()
            self.tacOpsCollection.reloadData()
        }
        let security = UIAlertAction(title: "Security", style: .default) { _ in
            self.presenter?.pickTacOps(sender: .security)
            self.clearChoosenTacOps()
            self.tacOpsCollection.reloadData()
        }
        let infiltration = UIAlertAction(title: "Infiltration", style: .default) { _ in
            self.presenter?.pickTacOps(sender: .infiltration)
        }
        let recon = UIAlertAction(title: "Recon", style: .default) { _ in
            self.presenter?.pickTacOps(sender: .recon)
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
