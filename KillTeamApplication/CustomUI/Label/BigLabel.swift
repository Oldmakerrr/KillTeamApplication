//
//  BigLabel.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import UIKit

class BigLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.bigBold
        textColor = ColorScheme.shared.theme.textHeader
        numberOfLines = 0
    }
}


