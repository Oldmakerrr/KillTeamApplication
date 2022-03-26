//
//  BoldTextLabel.swift
//  KillTeamApplication
//
//  Created by Apple on 22.03.2022.
//

import UIKit

class BoldTextLabel: UILabel {
    
    var boldSize: CGFloat = 19
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addText(bold: String, normal: String) {
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: boldSize)]
        let boldText = NSMutableAttributedString(string: "\(bold): ", attributes: attributBold)
        let normalText = NSAttributedString(string: normal)
        boldText.append(normalText)
        self.attributedText = boldText
    }
    
}
