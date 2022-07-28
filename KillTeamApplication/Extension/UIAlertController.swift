//
//  UIAlertController.swift
//  KillTeamApplication
//
//  Created by Apple on 08.05.2022.
//

import UIKit

extension UIAlertController {
    
    func inputText(_ index: Int = 0, maxTextLength: Int = 20) throws -> String? {
        guard let textFields = self.textFields,
              let text = textFields[index].text else { return nil }
        switch true {
        case text.isEmpty :
            throw InputTextError.invalidName
        case text.count > maxTextLength :
            throw InputTextError.toLongText
        default:
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
