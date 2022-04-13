//
//  PloysTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class PloysTableViewCell: UITableViewCell {
    
    static let identifier = "PloysTableViewCell"
    
    let ployView = PloyView()

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        contentView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
