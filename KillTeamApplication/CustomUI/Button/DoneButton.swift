//
//  DoneButton.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import UIKit

class DoneButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Done", for: .normal)
        setTitleColor(ColorScheme.shared.theme.textNormal, for: .normal)
        backgroundColor = ColorScheme.shared.theme.buttonBackground
        layer.masksToBounds = true
        layer.cornerRadius = Constant.Size.cornerRadius
        layer.borderWidth = Constant.Size.borderWidht
        layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
    }
}

