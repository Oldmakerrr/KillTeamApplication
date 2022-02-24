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
        collectionView.backgroundColor = .gray
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
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
}

extension ChoosenTacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosenTacOpsCell.identifier, for: indexPath) as! ChoosenTacOpsCell
        switch indexPath.item {
        case 0:
            if let tacOp = presenter?.model.gameData.firstTacOp {
                setupText(cell: cell, tacOp: tacOp)
            }
        case 1:
            if let tacOp = presenter?.model.gameData.secondTacOp {
                setupText(cell: cell, tacOp: tacOp)
            }
        case 2:
            if let tacOp = presenter?.model.gameData.thirdTacOp {
                setupText(cell: cell, tacOp: tacOp)
            }
        default:
            break
        }
        return cell
    }
    
    func setupText(cell: ChoosenTacOpsCell, tacOp: TacOps) {
        cell.tacOpView.nameLabel.text = tacOp.name
        cell.tacOpView.nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        cell.tacOpView.descriptionLabel.text = tacOp.description
        cell.tacOpView.descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        cell.tacOpView.setupSubView(view: cell.tacOpView.firstConditionView, label: cell.tacOpView.firstConditionLabel, text: tacOp.firstCondition, trailingSpace: 25)
        cell.tacOpView.firstConditionLabel.font = UIFont.systemFont(ofSize: 18)
        if let secondCondition = tacOp.secondCondition {
            cell.tacOpView.setupSubView(view: cell.tacOpView.secondConitionView, label: cell.tacOpView.secondConitionLabel, text: secondCondition, trailingSpace: 25)
            cell.tacOpView.secondConitionLabel.font = UIFont.systemFont(ofSize: 18)
        }
        if let subText = tacOp.subText {
            cell.tacOpView.setupSubView(view: cell.tacOpView.subView, label: cell.tacOpView.subLabel, text: subText, trailingSpace: 15)
            cell.tacOpView.subLabel.font = UIFont.systemFont(ofSize: 18)
        }
        if let action = tacOp.uniquiAction {
            let unitActionView = cell.tacOpView.unitActionView
            cell.tacOpView.addArrangedSubview(unitActionView)
            unitActionView.nameLabel.text = action.name
            unitActionView.coastLabel.text = "\(action.cost)AP"
            unitActionView.descriptionLabel.text = action.description
        }
        let progreesTacOp = tacOp.progreesTacOp
        switch progreesTacOp {
        case 0:
            cell.ProgressTacOplabel.text = "Tap to card if you complete Tac Op"
        case 1:
            cell.ProgressTacOplabel.text = "First part of Tac Op complete"
        case 2:
            cell.ProgressTacOplabel.text = "Tac Op complete"
            cell.alpha = 0.6
        default:
            break
        }
    }
    
}

extension ChoosenTacOpsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ChoosenTacOpsCell {
            switch indexPath.item {
            case 0:
                switch presenter?.model.gameData.firstTacOp?.progreesTacOp {
                case 0:
                if presenter?.model.gameData.firstTacOp?.secondCondition == nil {
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.firstTacOp?.progreesTacOp += 2
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.firstTacOp!.victoryPointForfirstCondition
                    cell.alpha = 0.6
                } else {
                    cell.ProgressTacOplabel.text = "First part of Tac Op complete"
                    presenter?.model.gameData.firstTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.firstTacOp!.victoryPointForfirstCondition
                }
                case 1:
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.firstTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.firstTacOp!.victoryPointSecondCondition!
                    cell.alpha = 0.6
                default:
                    break
                }
            case 1:
                switch presenter?.model.gameData.secondTacOp?.progreesTacOp {
                case 0:
                if presenter?.model.gameData.secondTacOp?.secondCondition == nil {
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.secondTacOp?.progreesTacOp += 2
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.secondTacOp!.victoryPointForfirstCondition
                    cell.alpha = 0.6
                } else {
                    cell.ProgressTacOplabel.text = "First part of Tac Op complete"
                    presenter?.model.gameData.secondTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.secondTacOp!.victoryPointForfirstCondition
                }
                case 1:
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.secondTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.secondTacOp!.victoryPointSecondCondition!
                    cell.alpha = 0.6
                default:
                    break
                }
            case 2:
                switch presenter?.model.gameData.thirdTacOp?.progreesTacOp {
                case 0:
                if presenter?.model.gameData.thirdTacOp?.secondCondition == nil {
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.thirdTacOp?.progreesTacOp += 2
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.thirdTacOp!.victoryPointForfirstCondition
                    cell.alpha = 0.6
                } else {
                    cell.ProgressTacOplabel.text = "First part of Tac Op complete"
                    presenter?.model.gameData.thirdTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.thirdTacOp!.victoryPointForfirstCondition
                }
                case 1:
                    cell.ProgressTacOplabel.text = "Tac Op complete"
                    presenter?.model.gameData.thirdTacOp?.progreesTacOp += 1
                    presenter?.model.gameData.countVictoryPoint += presenter!.model.gameData.thirdTacOp!.victoryPointSecondCondition!
                    cell.alpha = 0.6
                default:
                    break
                }
            default:
            break
            }
            presenter?.gameSore.updateGameData(gameData: presenter!.model.gameData)
        }
        
    }
}

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
