//
//  UIAlertController.swift
//  KillTeamApplication
//
//  Created by Apple on 08.05.2022.
//

import UIKit

extension UIAlertController {
    
    func inputText() throws -> String? {
        let textField = self.textFields?.first
        if let text = textField?.text {
            
            switch true {
            case text == "":
                throw InputTextError.invalidName
            case text.count > 20 :
                throw InputTextError.toLongText
            default:
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else {
            return nil
        }
    }
}
