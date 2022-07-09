//
//  CoachMarkRosterExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 02.06.2022.
//

import Instructions

extension RosterTableViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.animateSelect()
        coachView.bodyView.hintLabel.text = "Tap here to get more info about the unit"
        coachView.bodyView.nextLabel.text = "OK"
        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        return coachMarksController.helper.makeCoachMark(for: tableView.cellForRow(at: IndexPath(item: 0, section: 0)))
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
    
    
}


extension RosterTableViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}
