//
//  CoachMarkEditUnitExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Instructions

import Instructions

extension EditUnitViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Here you can see current number of Equipment Point"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            if let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) {
                cell.animateSelect()
            }
            coachView.bodyView.hintLabel.text = "Tap on cell - choose wargear"
            coachView.bodyView.nextLabel.text = "Next"
        case 2:
            previewSwipeActions(message: " Info ", swipeDirection: .left, tableView: tableView)
            coachView.bodyView.hintLabel.text = "Swipe left - more info about wargear"
            coachView.bodyView.nextLabel.text = "Ok"
        default:
            break
        }
        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        var coachMark = CoachMark()
        switch index {
        case 0:
            coachMark = coachMarksController.helper.makeCoachMark(for: countOfEquipmentPointLabel)
        default:
            coachMark = coachMarksController.helper.makeCoachMark(for: tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
   
}


extension EditUnitViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}
