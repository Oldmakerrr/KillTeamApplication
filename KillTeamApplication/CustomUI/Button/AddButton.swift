//
//  AddButton.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import UIKit

class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellBorder
        tintColor = ColorScheme.shared.theme.textDark
        layer.applySketchShadow()
        setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    func setupButton(tabBarController: UITabBarController, tabBarView: UIView) {
        tabBarView.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(greaterThanOrEqualTo: tabBarView.topAnchor),
            self.leadingAnchor.constraint(greaterThanOrEqualTo: tabBarView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -Constant.Size.screenWidth * 0.085),
            self.bottomAnchor.constraint(equalTo: tabBarController.tabBar.topAnchor, constant: -Constant.Size.screenWidth * 0.085),
            self.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.145),
            self.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
        self.layer.applyCornerRadiusRound(view: self)
    }
    
}
