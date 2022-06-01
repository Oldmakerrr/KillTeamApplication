//
//  CoachMarkAddFireTeamExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Instructions

extension AddFireTeamViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Here you may show Maximum number of Fire Team"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            coachView.bodyView.hintLabel.text = "Add and remove Fire Team, but sum added Fire Team not be more then maximum number of Fire Team"
            coachView.bodyView.nextLabel.text = "OK"
        default:
            break
        }
        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        var coachMark = CoachMark()
        switch index {
        case 0:
            coachMark = coachMarksController.helper.makeCoachMark(for: maxCountFIreTeamLabel)
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: tableView.cellForRow(at: IndexPath(item: 0, section: 0)))
        default:
            break
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
    
    
}
