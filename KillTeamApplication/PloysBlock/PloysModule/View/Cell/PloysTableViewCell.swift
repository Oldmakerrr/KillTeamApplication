//
//  PloysTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class PloysTableViewCell: UITableViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    private var ployView = PloyView()
    
    func setupPloy(ploy: Ploy, image: UIImage? = nil, delegate: WeaponRuleButtonDelegate) {
        ployView.setupPloy(ploy: ploy, image: image, delegate: delegate, viewWidth: UIScreen.main.bounds.width - 20)
        ployView.setupView()
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
            ployView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.small),
            ployView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            ployView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.EdgeInsets.small),
            ployView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.EdgeInsets.small)
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
