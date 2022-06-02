//
//  TacOpsViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class TacOpsViewController: UIViewController, TacOpsViewControllerProtocol {
    
    let coachMarksController = CoachMarksController()

    var presenter: TacOpsPresenterProtocol?
    
    let goToChoosenTacOpsButton = UIButton()
   
    let customAlert = CustomScrollAlert()
    
    var moreInfoTacOpView = TacOpView()
    let changeTacOpsTypeButton = UIButton()
    let mixDeckButton = UIButton()
    
    let tacOpsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Seek & Destroy"
        setupTacOpsCollection()
        moreInfoTacOpView.delegate = self
        setupRightBarButton()
        setupGoToChoosenTacOpsButton()
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tacOpsCollection.reloadData()
        if let bool = presenter?.checkSelectTacOp {
            goToChoosenTacOpsButton.isEnabled = bool()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coachMarksController.start(in: .window(over: self))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coachMarksController.stop()
    }
    
}

//MARK: - CollectionViewDataSource

extension TacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TacOpsCollectionCell.identifier, for: indexPath) as! TacOpsCollectionCell
        cell.tacOp = presenter?.model.currentDeck[indexPath.item]
        cell.index = Int(indexPath.row)
        cell.delegate = presenter as? TacOpsCollectionCellDelegate
        cell.buttonDelegate = self
        cell.setupText(tacOps: presenter!.model.currentDeck[indexPath.item])
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
        let height = itemHeight(itemsInRow: 3, spacing: 10)
        return CGSize(width: widht, height: height)
    }
    
    func itemWidht(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let widhtScreen = Constant.Size.screenWidth
        return (widhtScreen - totalSpacing) / itemsInRow
    }
    
    func itemHeight(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let safeArea = view.safeAreaLayoutGuide
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let heightScreen = safeArea.layoutFrame.size.height
        return (heightScreen - totalSpacing) / itemsInRow
    }

}

//MARK: - Extension TacOpsViewController

extension TacOpsViewController: TacOpsCollectionCellButtonDelegate {
    func didSelect(_ cell: TacOpsCollectionCell) {
        showAlert(tacOp: cell.tacOp!)
    }
}

extension TacOpsViewController: TacOpDelegate {
    func didComplete(_ view: TacOpView) {
        dismissAlert()
    }
}

extension TacOpsViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}
