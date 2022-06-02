//
//  CoachMarkTacOpsExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 02.06.2022.
//

import Instructions
import CoreGraphics

extension TacOpsViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Mark 1"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            coachView.bodyView.hintLabel.text = "MArk 2"
            coachView.bodyView.nextLabel.text = "Next"
        case 2:
            coachView.bodyView.hintLabel.text = "Mark 3"
            coachView.bodyView.nextLabel.text = "Next"
        case 3:
            coachView.bodyView.hintLabel.text = "Mark 4"
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
            coachMark = coachMarksController.helper.makeCoachMark(for: goToChoosenTacOpsButton)
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: mixDeckButton)
        case 2:
            coachMark = coachMarksController.helper.makeCoachMark(for: changeTacOpsTypeButton)
        case 3:
            coachMark = coachMarksController.helper.makeCoachMark(for: tacOpsCollection.cellForItem(at: IndexPath(row: 0, section: 0)))

        default:
            break
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 4
    }
    
    
}


extension TacOpsViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}
