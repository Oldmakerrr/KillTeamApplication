//
//  InfoButton.swift
//  KillTeamApplication
//
//  Created by Apple on 18.04.2022.
//

import Foundation
import UIKit

class InfoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "info.circle"), for: .normal)
        tintColor = ColorScheme.shared.theme.swipeInfoAction
    }
    
}
