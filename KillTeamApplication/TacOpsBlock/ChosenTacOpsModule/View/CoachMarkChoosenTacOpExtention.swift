//
//  CoachMarkChoosenTacOpExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 04.06.2022.
//

import Instructions

extension ChosenTacOpsViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Press to mark completed mission"
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            let cell = choosenTacOpsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0))
            cell?.swipeAnimate()
            coachView.bodyView.hintLabel.text = "Swipe to go to the next Tac Op"
            coachView.bodyView.nextLabel.text = "OK"
        default:
            break
        }
        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        var coachMark = CoachMark()
        guard let cell = choosenTacOpsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ChosenTacOpsCell else { return CoachMark() }
        switch index {
        case 0:
            coachMark = coachMarksController.helper.makeCoachMark(for: cell.tacOpView.viewArray.first)
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: cell)
        default:
            break
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
    
    
    
    
}


extension ChosenTacOpsViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}

