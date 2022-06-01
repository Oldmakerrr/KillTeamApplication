//
//  CoachMarkExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import UIKit
import Instructions

extension CounterViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachView.bodyView.hintLabel.text = "Tap here and you may Edit your Kill Team, if Kill Team hasn't been choosen you may choose Kill Team from list."
            coachView.bodyView.nextLabel.text = "Next"
        case 1:
            coachView.bodyView.hintLabel.text = "You may manage and observe for your game Resources."
            coachView.bodyView.nextLabel.text = "Next"
        case 2:
            coachView.bodyView.hintLabel.text = "Tap here to create new Kill Team"
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
            coachMark = coachMarksController.helper.makeCoachMark(for: currentKillTeamView)
            return coachMark
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: counterLabelsStackView)
        case 2:
            coachMark = coachMarksController.helper.makeCoachMark(for: addKillTeamButton)
            return coachMark
        default:
            break
        }
        return coachMark
    }
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
    
    
    
    
    
}
