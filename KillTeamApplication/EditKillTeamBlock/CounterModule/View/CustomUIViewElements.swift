//
//  CustomUIViewElements.swift
//  KillTeamApplication
//
//  Created by Apple on 11.04.2022.
//

import Foundation
import UIKit

class CounterLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.boldFont
        textAlignment = .center
        font = UIFont.systemFont(ofSize: Constant.Size.screenHeight * 0.025)
        textColor = ColorScheme.shared.theme.textDark
        numberOfLines = 0
    }
}

class ChangePointButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(imageName: String) {
        setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.buttonBackground
        layer.applySketchShadow()
        layer.applyBorder()
        tintColor = ColorScheme.shared.theme.viewHeader
    }
}

class ChangeTurnButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.buttonBackground
        setTitleColor(ColorScheme.shared.theme.textDark, for: .normal)
        layer.applySketchShadow()
        layer.applyBorder()
        layer.applyCornerRadius()
        tintColor = ColorScheme.shared.theme.viewHeader
    }
}

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
        setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
}
