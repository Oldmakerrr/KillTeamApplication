//
//  CurrentPloysCollectionViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 12.04.2022.
//

import Foundation
import UIKit

class CurrentPloysCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentPloysCollectionViewCell"
    
    private let nameLabel: NormalLabel = {
        let label = NormalLabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(ploy: Ploy) {
        nameLabel.text = ploy.name
    }
    
    private func configure() {
        backgroundColor = ColorScheme.shared.theme.cellBackground
        alpha = 0.5
        layer.applyCornerRadius()
    }
    
    private func setupSubView() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.normal),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.normal),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
