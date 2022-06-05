//
//  CoachMarkChoosenTacOpExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 04.06.2022.
//

import Instructions

extension ChoosenTacOpsViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "You can select and check completed mission"
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
            if let cell = choosenTacOpsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ChoosenTacOpsCell {
                coachMark = coachMarksController.helper.makeCoachMark(for: cell.tacOpView.viewArray.first)
            }
        default:
            break
        }
        return coachMark
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
    
    
}


extension ChoosenTacOpsViewController: CoachMarksControllerAnimationDelegate {
    
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchAppearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.parameters.duration = 0.7
    }
    
}

