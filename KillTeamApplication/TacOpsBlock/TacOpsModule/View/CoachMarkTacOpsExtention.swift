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
            coachView.bodyView.hintLabel.text = "After you select three Tac Ops tap here to go to the screen with your chosen Tac Ops"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            coachView.bodyView.hintLabel.text = "Tap to mix deck"
            coachView.bodyView.nextLabel.text = "Next"
        case 2:
            coachView.bodyView.hintLabel.text = "Tap to change the type of Tac Ops"
            coachView.bodyView.nextLabel.text = "Next"
        case 3:
            coachView.bodyView.hintLabel.text = "Tap to select this Tac Op. You need choose a total of three Tac Ops"
            coachView.bodyView.nextLabel.text = "Next"
        case 4:
            coachView.bodyView.hintLabel.text = "Tap to get more info about this Tac Op"
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
        case 4:
            if let cell = tacOpsCollection.cellForItem(at: IndexPath(row: 0, section: 0)) as? TacOpsCollectionCell {
                coachMark = coachMarksController.helper.makeCoachMark(for: cell.moreInfoButton)
            }
        default:
            break
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 5
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
