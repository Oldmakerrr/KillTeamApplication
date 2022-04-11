//
//  TacOpsViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class TacOpsViewController: UIViewController, TacOpsViewControllerProtocol {

    var presenter: TacOpsPresenterProtocol?
    let editButton = UIBarButtonItem()
    let goToChoosenTacOpsButton = UIBarButtonItem()
   // lazy var customAlert = CustomAlert(alertView: moreInfoTacOpView, targetView: self)
    let customAlert = CustomAlert()
    var moreInfoTacOpView = MoreInfoTacOp()
    var tacOpsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        return collectionView
    }()
    var selectedTapOp: TacOps?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTacOpsCollection()
        setupButton()
        setupGoToChoosenTacOpsButton()
        moreInfoTacOpView.delegate = self
    }
    
    func setCellColor(tacOp: TacOps, index: Int) {
        guard let cell = tacOpsCollection.visibleCells[index] as? TacOpsCollectionCell else { return }
        if cell.tacOp == tacOp {
            cell.contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
            
        } else {
            cell.contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
            cell.layer.applySketchShadow()
        }
    }
    
    private func updateCellColor() {
        guard let firstTacOp = presenter?.model.gameData.firstTacOp,
              let secondTacOp = presenter?.model.gameData.secondTacOp,
              let thirdTacOp = presenter?.model.gameData.thirdTacOp
              else { return }
        for cell in tacOpsCollection.visibleCells {
            if let cell = cell as? TacOpsCollectionCell {
                switch cell.index {
                case 0:
                    setCellColor(tacOp: firstTacOp, index: 0)
                case 1:
                    setCellColor(tacOp: firstTacOp, index: 1)
                case 2:
                    setCellColor(tacOp: secondTacOp, index: 2)
                case 3:
                   setCellColor(tacOp: secondTacOp, index: 3)
                case 4:
                    setCellColor(tacOp: thirdTacOp, index: 4)
                case 5:
                    setCellColor(tacOp: thirdTacOp, index: 5)
                default:
                    break
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCellColor()
    }
   
    func moreInfoAlert(tacOp: TacOps) {
        setupTextAlert(tacOp: tacOp)
        customAlert.showAlert(alertView: moreInfoTacOpView, targetView: self)
        
     //   customAlert.showAlert()
    }
    
    func hideUnfoAlert() {
        customAlert.dismissAlert()
        moreInfoTacOpView = MoreInfoTacOp()
        moreInfoTacOpView.delegate = self
     //   moreInfoTacOpView.secondConitionView.removeFromSuperview()
     //   moreInfoTacOpView.subView.removeFromSuperview()
     //   moreInfoTacOpView.unitActionView.removeFromSuperview()
    }
    
    func setupTextAlert(tacOp: TacOps) {
        moreInfoTacOpView.setupText(tacOp: tacOp)
        moreInfoTacOpView.setupSubView(view: moreInfoTacOpView.firstConditionView, label: moreInfoTacOpView.firstConditionLabel, text: tacOp.firstCondition, trailingSpace: 20)
        if tacOp.secondCondition != nil {
            moreInfoTacOpView.setupSubView(view: moreInfoTacOpView.secondConitionView, label: moreInfoTacOpView.secondConitionLabel, text: tacOp.secondCondition!, trailingSpace: 20)
        }
        
        if tacOp.subText != nil {
            moreInfoTacOpView.setupSubView(view: moreInfoTacOpView.subView, label: moreInfoTacOpView.subLabel, text: tacOp.subText!, trailingSpace: 15)
        }
        
        if tacOp.uniquiAction != nil {
            let actionView = moreInfoTacOpView.unitActionView
            moreInfoTacOpView.addArrangedSubview(actionView)
            actionView.nameLabel.text = tacOp.uniquiAction?.name
            actionView.coastLabel.text = String(tacOp.uniquiAction!.cost)
            actionView.descriptionLabel.text = tacOp.uniquiAction?.description
        }
        moreInfoTacOpView.setupButton()
    }
    
    @objc func edit() {
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
    
    private func setupButton() {
        navigationItem.rightBarButtonItem = editButton
        editButton.image = UIImage(systemName: "plus")
        editButton.target = self
        editButton.action = #selector(edit)
    }
    
    private func setupGoToChoosenTacOpsButton() {
        navigationItem.leftBarButtonItem = goToChoosenTacOpsButton
        goToChoosenTacOpsButton.image = UIImage(systemName: "square.and.arrow.up")
        goToChoosenTacOpsButton.target = self
        goToChoosenTacOpsButton.action = #selector(goToChoosenTacOpsView)
       // goToChoosenTacOpsButton.isEnabled = false
    }
    
    @objc func goToChoosenTacOpsView() {
        presenter?.goToChoosenTacOps()
    }
    private func clearChoosenTacOps() {
        for cell in self.tacOpsCollection.visibleCells {
            cell.contentView.backgroundColor = .systemGray2
        }
        presenter?.model.firstTacOp = nil
        presenter?.model.secondTacOp = nil
        presenter?.model.thirdTacOp = nil
    }
    
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
    
}

extension TacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TacOpsCollectionCell.identifier, for: indexPath) as! TacOpsCollectionCell
        cell.tacOp = presenter?.model.customTacOps[indexPath.item]
        cell.index = Int(indexPath.row)
        cell.delegate = presenter as? TacOpsCollectionCellDelegate
        cell.infoDelegate = self
        if presenter!.model.customTacOps.count != 0 {
            cell.setupText(tacOps: presenter!.model.customTacOps[indexPath.item])
        }
        return cell
    }
}

extension TacOpsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !presenter!.model.customTacOps.isEmpty {
            let tacOp = presenter?.model.customTacOps[indexPath.item]
            presenter?.selectTacOp(tacOp: tacOp!, indexPath: indexPath)
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? TacOpsCollectionCell {
            cell.delegate?.didSelect(cell)
        }
    }
}
   
extension TacOpsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = itemWidht(itemsInRow: 2, spacing: 10)
        let height = itemHeight(itemsInRow: 3, spacing: 60)
        return CGSize(width: widht, height: height)
    }
    
    func itemWidht(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let widhtScreen = view.frame.size.width
        return (widhtScreen - totalSpacing) / itemsInRow
    }
    
    func itemHeight(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let heightScreen = view.frame.size.height
        return (heightScreen - totalSpacing) / itemsInRow
    }

}

extension TacOpsViewController: TacOpsCollectionCellForInfoDelegate {
    func didSelect(_ cell: TacOpsCollectionCell) {
        moreInfoAlert(tacOp: cell.tacOp!)
    }
}

extension TacOpsViewController: MoreInfoTacOpDelegate {
    func didComplete(_ view: MoreInfoTacOp) {
        hideUnfoAlert()
    }
}
