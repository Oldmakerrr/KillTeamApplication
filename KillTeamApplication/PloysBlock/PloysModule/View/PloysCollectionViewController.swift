//
//  PloysCollectionViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import  UIKit

class PloysViewControllerII: UIViewController, PloysViewControllerProtocol {

    var presenter: PloysPresenterProtocol?
   
    
    let ploysCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ploys"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ploysCollection.reloadData()
    }
    
//MARK: - Methods
    
    func setupTacOpsCollection() {
        view.addSubview(ploysCollection)
        ploysCollection.dataSource = self
        ploysCollection.delegate = self
        ploysCollection.translatesAutoresizingMaskIntoConstraints = false
        ploysCollection.register(PloysCollectionViewCell.self, forCellWithReuseIdentifier: PloysCollectionViewCell.identifier)
        NSLayoutConstraint.activate([
            ploysCollection.topAnchor.constraint(equalTo: view.topAnchor),
            ploysCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ploysCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ploysCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}

//MARK: - CollectionViewDataSource

extension PloysViewControllerII: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let strategicPloy = presenter?.model.strategicPloy
        let tacticalPloy = presenter?.model.tacticalPloy
        switch section {
        case 0:
            return strategicPloy?.count ?? 0
        default:
            return tacticalPloy?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PloysCollectionViewCell.identifier, for: indexPath) as! PloysCollectionViewCell
        switch indexPath.section {
            case 0:
                let strategicPloy = presenter!.model.strategicPloy[indexPath.row]
                cell.ployView.setupPloy(ploy: strategicPloy, delegate: self)
                return cell
            default:
                let tacticalPloy = presenter!.model.tacticalPloy[indexPath.row]
                cell.ployView.setupPloy(ploy: tacticalPloy, delegate: self)
                return cell
            }
    }
    
    func usePloyAlert(ploy: Ploy, question: String, succes: String) {
        let alertController = UIAlertController(title: nil, message: question, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Yes", style: .default) { _ in
            if ploy.cost > self.presenter!.model.gameData.countCommandPoint {
                let alertController = UIAlertController(title: nil, message: "You have not enough command point.", preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "Done", style: .cancel, handler: nil)
                alertController.addAction(alertOk)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.presenter!.model.gameData.countCommandPoint -= ploy.cost
                if ploy.type == "strategic" {
                    self.presenter?.model.gameData.currentStrategicPloys.append(ploy)
                }
                self.presenter?.gameStore.updateGameData(gameData: self.presenter!.model.gameData)
                let alertController = UIAlertController(title: nil, message: succes, preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "Done", style: .cancel, handler: nil)
                alertController.addAction(alertOk)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let alertNo = UIAlertAction(title: "No, i changed my mind", style: .cancel, handler: nil)
        alertController.addAction(alertOk)
        alertController.addAction(alertNo)
        present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: - UICollectionViewDelegate

extension PloysViewControllerII: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let strategicPloy = presenter!.model.strategicPloy[indexPath.row]
            if self.presenter!.model.gameData.currentStrategicPloys.contains(strategicPloy) {
                let alertController = UIAlertController(title: nil, message: "You have already used this stratigic ploy in that Turning Point", preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "Done", style: .cancel, handler: nil)
                alertController.addAction(alertOk)
                self.present(alertController, animated: true, completion: nil)
            } else {
                usePloyAlert(ploy: strategicPloy, question: "Do you want to use this strategic ploy?", succes: "This strategic ploy successfully used.")
            }
        default:
            let tacticalPloy = presenter!.model.tacticalPloy[indexPath.row]
            usePloyAlert(ploy: tacticalPloy, question: "Do you want to use this tactical ploy?", succes: "This tactical ploy successfully used.")
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
   
extension PloysViewControllerII: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = itemWidht(itemsInRow: 2, spacing: 10)
        let height = itemHeight(itemsInRow: 3, spacing: Constant.Size.screenHeight * 0.057)
        return CGSize(width: widht, height: height)
    }
    
    func itemWidht(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let widhtScreen = Constant.Size.screenWidth
        return (widhtScreen - totalSpacing) / itemsInRow
    }
    
    func itemHeight(itemsInRow: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let heightScreen = Constant.Size.screenHeight
        return (heightScreen - totalSpacing) / itemsInRow
    }

}

//MARK: - Extension TacOpsViewController

extension PloysViewControllerII: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}

