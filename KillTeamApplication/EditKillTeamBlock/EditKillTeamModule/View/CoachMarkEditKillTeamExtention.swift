//
//  CoachMarkEditKillTeamExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Instructions
import UIKit

extension EditKillTeamTableViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Tap on cell - Edit Unit"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            coachView.bodyView.hintLabel.text = "Left Swipe - Change or Rename unit"
            previewSwipeActions(message: "Change", actionBackgroundColor: UIColor.orange, swipeDirection: .left, tableView: tableView)
            coachView.bodyView.nextLabel.text = "Next"
        case 2:
            coachView.bodyView.hintLabel.text = "Right swipe - Remove unit"
            previewSwipeActions(message: "Remove", actionBackgroundColor: UIColor.red, swipeDirection: .right, tableView: tableView)
            coachView.bodyView.nextLabel.text = "Next"
        case 3:
            coachView.bodyView.hintLabel.text = "You may add new Unit or Fire Team."
            coachView.bodyView.nextLabel.text = "OK"
        default:
            break
        }
        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 3:
            return coachMarksController.helper.makeCoachMark(for: addUnitOrFireTeamButton)
        default:
            return coachMarksController.helper.makeCoachMark(for: tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
            
        }
        
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        4
    }
    
    
}
