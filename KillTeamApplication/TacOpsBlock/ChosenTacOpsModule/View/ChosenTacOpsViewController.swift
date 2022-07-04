//
//  ChosenTacOpsViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import UIKit
import Instructions

class ChosenTacOpsViewController: UIViewController, ChosenTacOpsViewControllerProtocol {
    
    let coachMarksController = CoachMarksController()
  
    var presenter: ChosenTacOpsPresenterProtocol?
    
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
        choosenTacOpsCollectionView.dataSource = self
        choosenTacOpsCollectionView.delegate = self
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coachMarksController.stop(immediately: true)
    }
    
    func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
    func setupTacOpsCollection() {
        view.addSubview(choosenTacOpsCollectionView)
        choosenTacOpsCollectionView.isPagingEnabled = true
        choosenTacOpsCollectionView.indicatorStyle = .black
        choosenTacOpsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        choosenTacOpsCollectionView.register(ChosenTacOpsCell.self, forCellWithReuseIdentifier: ChosenTacOpsCell.identifier)
        NSLayoutConstraint.activate([
            choosenTacOpsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            choosenTacOpsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            choosenTacOpsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            choosenTacOpsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCell(cell: ChosenTacOpsCell, tacOp: TacOp, indexPath: IndexPath) {
        cell.setupText(tacOp: tacOp, delegate: self, conditionViewDelegate: presenter as! ChosenTacOpViewDelegate)
        cell.tacOpView.indexPath = indexPath
    }
    
}

//MARK: - UICollectionViewDataSource

extension ChosenTacOpsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let firstTacOp = presenter?.model.gameData.firstTacOp,
              let secondTacOp = presenter?.model.gameData.secondTacOp,
              let thirdTacOp = presenter?.model.gameData.thirdTacOp else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChosenTacOpsCell.identifier, for: indexPath) as! ChosenTacOpsCell
        cell.updateCell()
        switch indexPath.item {
        case 0:
            setupCell(cell: cell, tacOp: firstTacOp, indexPath: indexPath)
        case 1:
            setupCell(cell: cell, tacOp: secondTacOp, indexPath: indexPath)
        case 2:
            setupCell(cell: cell, tacOp: thirdTacOp, indexPath: indexPath)
        default:
            return cell
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ChosenTacOpsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = itemWidht(itemsInRow: 1, spacing: 10)
        let height = itemHeight(itemsInRow: 1, spacing: 10)
        return CGSize(width: widht, height: height)
    }
    
    func itemWidht(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let widhtScreen = view.frame.size.width
        return (widhtScreen - totalSpacing) / itemsInRow
    }
    
    func itemHeight(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let safeArea = view.safeAreaLayoutGuide
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let heightScreen = safeArea.layoutFrame.size.height
        return (heightScreen - totalSpacing) / itemsInRow
    }
}

//MARK: - Extension

extension ChosenTacOpsViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}
