//
//  BoldLabel.swift
//  KillTeamApplication
//
//  Created by Apple on 28.03.2022.
//

import Foundation
import UIKit

class BoldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.bold
        textColor = ColorScheme.shared.theme.textNormal
        numberOfLines = 0
    }
}
