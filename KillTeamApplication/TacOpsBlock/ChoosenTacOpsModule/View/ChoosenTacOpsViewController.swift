//
//  ChoosenTacOpsViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import UIKit

class ChoosenTacOpsViewController: UIViewController, ChoosenTacOpsViewControllerProtocol {
  
    var presenter: ChoosenTacOpsPresenterProtocol?
    
    let choosenTacOpsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTacOpsCollection()
    }
    
    func setupTacOpsCollection() {
        view.addSubview(choosenTacOpsCollectionView)
        choosenTacOpsCollectionView.isPagingEnabled = true
        choosenTacOpsCollectionView.indicatorStyle = .black
        choosenTacOpsCollectionView.dataSource = self
        choosenTacOpsCollectionView.delegate = self
        choosenTacOpsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        choosenTacOpsCollectionView.register(ChoosenTacOpsCell.self, forCellWithReuseIdentifier: ChoosenTacOpsCell.identifier)
        NSLayoutConstraint.activate([
            choosenTacOpsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            choosenTacOpsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            choosenTacOpsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            choosenTacOpsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func progressTacOp(cell: ChoosenTacOpsCell, tacOp: TacOps) -> TacOps {
        var tacOp = tacOp
        switch tacOp.progreesTacOp {
        case 0:
        if tacOp.secondCondition == nil {
            cell.ProgressTacOplabel.text = "Tac Op complete"
            tacOp.progreesTacOp += 2
            presenter?.model.gameData.countVictoryPoint += tacOp.victoryPointForfirstCondition
            cell.alpha = 0.6
        } else {
            cell.ProgressTacOplabel.text = "First part of Tac Op complete"
            tacOp.progreesTacOp += 1
            presenter?.model.gameData.countVictoryPoint += tacOp.victoryPointForfirstCondition
        }
        case 1:
            cell.ProgressTacOplabel.text = "Tac Op complete"
            tacOp.progreesTacOp += 1
            presenter?.model.gameData.countVictoryPoint += tacOp.victoryPointSecondCondition!
            cell.alpha = 0.6
        default:
            break
        }
        return tacOp
    }
    
    func someMethod(cell: ChoosenTacOpsCell, indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            if let firstTacOp = presenter?.model.firstTacOp {
                let tacOp = progressTacOp(cell: cell, tacOp: firstTacOp)
                presenter?.model.firstTacOp = tacOp
            }
        case 1:
            if let firstTacOp = presenter?.model.secondTacOp {
                let tacOp = progressTacOp(cell: cell, tacOp: firstTacOp)
                presenter?.model.secondTacOp = tacOp
            }
        case 2:
            if let firstTacOp = presenter?.model.thirdTacOp {
                let tacOp = progressTacOp(cell: cell, tacOp: firstTacOp)
                presenter?.model.thirdTacOp = tacOp
            }
        default:
        break
        }
    }
    
}

//MARK: - UICollectionViewDataSource

extension ChoosenTacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosenTacOpsCell.identifier, for: indexPath) as! ChoosenTacOpsCell
        //let cell = ChoosenTacOpsCell()
        switch indexPath.item {
        case 0:
            if let tacOp = presenter?.model.gameData.firstTacOp {
                cell.tacOpView.setupText(tacOp: tacOp, delegate: self)
            }
        case 1:
            if let tacOp = presenter?.model.gameData.secondTacOp {
                cell.tacOpView.setupText(tacOp: tacOp, delegate: self)
            }
        case 2:
            if let tacOp = presenter?.model.gameData.thirdTacOp {
                cell.tacOpView.setupText(tacOp: tacOp, delegate: self)
            }
        default:
            return cell
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ChoosenTacOpsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ChoosenTacOpsCell {
            someMethod(cell: cell, indexPath: indexPath)
            presenter?.updateGameData()
        }
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ChoosenTacOpsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = itemWidht(itemsInRow: 1, spacing: 5)
        let height = itemHeight(itemsInRow: 1, spacing: 120)
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

//MARK: - Extension

extension ChoosenTacOpsViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}
