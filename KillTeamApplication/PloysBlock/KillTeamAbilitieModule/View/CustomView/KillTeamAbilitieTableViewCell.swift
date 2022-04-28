//
//  KillTeamAbilitieTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class KillTeamAbilitieTableViewCell<T: UIView>: UITableViewCell, ReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var view = T()
    
    func updateCell() {
        view.removeFromSuperview()
        self.view = T()
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}
