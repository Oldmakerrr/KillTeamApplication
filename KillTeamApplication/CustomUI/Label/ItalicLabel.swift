//
//  ItalicLabel.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class ItalicLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.italic
        textColor = ColorScheme.shared.theme.textNormal
        numberOfLines = 0
    }
}
