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
        font = Constant.Font.boldFont
        textColor = ColorScheme.shared.theme.textNormal
        numberOfLines = 0
    }
}

class NormalLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.systemFont
        textColor = ColorScheme.shared.theme.textNormal
        numberOfLines = 0
    }
}

class HeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Constant.Font.headerFont
        textColor = ColorScheme.shared.theme.textHeader
        numberOfLines = 0
    }
}



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
        //layer.shadowOpacity = 1
        //layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
