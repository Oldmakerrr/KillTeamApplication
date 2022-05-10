//
//  CurrentPloysCollectionView.swift
//  KillTeamApplication
//
//  Created by Apple on 12.04.2022.
//

import Foundation
import UIKit

protocol  CurrentPloysCollectionViewDelegate: AnyObject {
    func didSelectCell(_ CurrentPloysCollectionView: CurrentPloysCollectionView, indexPath: IndexPath)
}

class CurrentPloysCollectionView: UICollectionView {
    
    weak var selectCellDelegate: CurrentPloysCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
        register(CurrentPloysCollectionViewCell.self, forCellWithReuseIdentifier: CurrentPloysCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .none
        delegate = self
    }
    
}

extension CurrentPloysCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCellDelegate?.didSelectCell(self, indexPath: indexPath)
    }
    
}

extension CurrentPloysCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.numberOfItems(inSection: 0) == 1 {
            return CGSize(width: collectionView.frame.width - 60, height: 40)
        } else {
            return CGSize(width: collectionView.frame.width/2 - 5, height: 40)
        }
    }
    
}
