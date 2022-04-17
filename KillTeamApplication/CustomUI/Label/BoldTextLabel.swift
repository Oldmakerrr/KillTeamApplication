//
//  BoldTextLabel.swift
//  KillTeamApplication
//
//  Created by Apple on 22.03.2022.
//

import UIKit

class BoldTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = ColorScheme.shared.theme.textNormal
        numberOfLines = 0
        font = Constant.Font.normal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addText(bold: String, normal: String) {
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Constant.Font.sizeNormalFont)]
        let boldText = NSMutableAttributedString(string: "\(bold): ", attributes: attributBold)
        let normalText = NSAttributedString(string: normal)
        boldText.append(normalText)
        self.attributedText = boldText
    }
    
}
