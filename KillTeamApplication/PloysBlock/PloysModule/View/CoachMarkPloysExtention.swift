//
//  CoachMarkPloysExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 02.06.2022.
//

import Instructions

extension PloysViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Here you may show number of Command Point"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.animateSelect()
            coachView.bodyView.hintLabel.text = "Tap cell - use Ploy, you can't used it if you have not enothe Command Point"
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
            coachMark = coachMarksController.helper.makeCoachMark(for: commandPointLabel)
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


extension PloysViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}
