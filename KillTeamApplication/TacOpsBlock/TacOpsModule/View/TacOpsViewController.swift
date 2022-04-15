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
   
    let customAlert = CustomAlert()
    var moreInfoTacOpView = MoreInfoTacOp()
    
    let tacOpsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTacOpsCollection()
        moreInfoTacOpView.delegate = self
        
        setupButton()
        setupGoToChoosenTacOpsButton()
        
    }
    
    
}

//MARK: - CollectionViewDataSource

extension TacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TacOpsCollectionCell.identifier, for: indexPath) as! TacOpsCollectionCell
        cell.tacOp = presenter?.model.customTacOps[indexPath.item]
        cell.index = Int(indexPath.row)
        cell.delegate = presenter as? TacOpsCollectionCellDelegate
        cell.buttonDelegate = self
        cell.setupText(tacOps: presenter!.model.customTacOps[indexPath.item])
        switch indexPath.item {
        case 0, 1:
            cell.setupColor(tacOp: presenter?.model.gameData.firstTacOp)
        case 2, 3:
            cell.setupColor(tacOp: presenter?.model.gameData.secondTacOp)
        case 4, 5:
            cell.setupColor(tacOp: presenter?.model.gameData.thirdTacOp)
        default:
            return cell
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension TacOpsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacOpsCollectionCell {
            cell.delegate?.didSelect(cell)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
   
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

//MARK: - Extension TacOpsViewController

extension TacOpsViewController: TacOpsCollectionCellButtonDelegate {
    func didSelect(_ cell: TacOpsCollectionCell) {
        showAlert(tacOp: cell.tacOp!)
    }
}

extension TacOpsViewController: MoreInfoTacOpDelegate {
    func didComplete(_ view: MoreInfoTacOp) {
        dismissAlert()
    }
}

extension TacOpsViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}
