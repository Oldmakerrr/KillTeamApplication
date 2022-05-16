//
//  CustomUIViewElements.swift
//  KillTeamApplication
//
//  Created by Apple on 11.04.2022.
//

import Foundation
import UIKit

//MARK: - Label

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
        font = Constant.Font.bold
        textAlignment = .center
        font = UIFont.systemFont(ofSize: Constant.Size.screenHeight * 0.025)
        textColor = ColorScheme.shared.theme.textDark
        numberOfLines = 0
    }
}

//MARK: - Buttons

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
        layer.applyBorder()
        tintColor = ColorScheme.shared.theme.viewHeader
    }
}

class ChangePointButtonN: UIButton {
    
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = #colorLiteral(red: 0.293800056, green: 0.2970282733, blue: 0.3509224057, alpha: 1)
        setBackgroundImage(UIImage(systemName: imageName), for: .normal)
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
        backgroundColor = #colorLiteral(red: 0.293800056, green: 0.2970282733, blue: 0.3509224057, alpha: 1)
        setTitleColor(#colorLiteral(red: 0.5879502892, green: 0.5915290713, blue: 0.6288157105, alpha: 1), for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 0.502659142, blue: 0, alpha: 1), for: .highlighted)
        layer.applyCornerRadius()
    }
}
