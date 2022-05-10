//
//  AddFireTeamButton.swift
//  KillTeamApplication
//
//  Created by Apple on 09.05.2022.
//

import UIKit

class AddFireTeamButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.buttonBackground
        layer.masksToBounds = true
        layer.cornerRadius = Constant.Size.cornerRadius
        layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
        layer.borderWidth = Constant.Size.borderWidht
    }
    
}
