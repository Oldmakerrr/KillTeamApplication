//
//  PloysCollectionViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import UIKit

class PloysCollectionViewCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    private var ployView = PloyView()
    
    func setupPloy(ploy: Ploy, delegate: WeaponRuleButtonDelegate) {
        ployView.setupPloy(ploy: ploy, delegate: delegate)
    }
    
    func updateCell() {
        ployView.removeFromSuperview()
        ployView = PloyView()
        setupView()
    }

    private func setupView() {
        contentView.addSubview(ployView)
        ployView.layer.applyCornerRadius()
        ployView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            ployView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.small),
            ployView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.small),
            ployView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.small),
            ployView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.Otstup.small)
        ])
    }
    
    func ads() {
        ployView.layoutIfNeeded()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth - 10),
            heightAnchor.constraint(equalToConstant: ployView.frame.size.height)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        contentView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        ads()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
