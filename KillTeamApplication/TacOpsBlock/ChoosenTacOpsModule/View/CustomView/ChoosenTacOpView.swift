//
//  ChoosenTacOpView.swift
//  KillTeamApplication
//
//  Created by Apple on 24.04.2022.
//

import Foundation
import UIKit

protocol ChoosenTacOpViewDelegate: AnyObject {
    func didSelectConditionView(_ tacOpView: ChoosenTacOpView, isSelect: Bool, indexPath: IndexPath?, numberOfCondition: Int)
}


class ChoosenTacOpView: TacOpView {
    
    weak var conditionViewDelegate: ChoosenTacOpViewDelegate?
    
    var boolArray: [Bool] = []
    var viewArray: [ConditionView] = []
    var gestureArray: [UITapGestureRecognizer] = []
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    @objc private func selectView(sender: UITapGestureRecognizer) {
        var index = 0
        for (i, gesture) in gestureArray.enumerated() {
            if gesture == sender {
                index = i
            }
        }
        conditionViewDelegate?.didSelectConditionView(self, isSelect: boolArray[index], indexPath: indexPath, numberOfCondition: index)
    }
    
    private func setupImage(conditionView: ConditionView, isSelectCondition: Bool) {
        if isSelectCondition {
            conditionView.setupImage(image: UIImage(systemName: "checkmark.square"))
        } else {
            conditionView.setupImage(image: UIImage(systemName: "square"))
        }
    }
    
    override func setupText(tacOp: TacOp, delegate: WeaponRuleButtonDelegate) {            for condition in tacOp.isCompletedConditions {
                boolArray.append(condition)
        }
        super.setupText(tacOp: tacOp, delegate: delegate)
    }
    
    override func addConditionTextView(text: String, trailingSpace: CGFloat) {
        
        let view = ConditionView()
        view.setupText(text: text)
        viewArray.append(view)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectView))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        gestureArray.append(gesture)
        
        let index = viewArray.count - 1
        setupImage(conditionView: viewArray[index], isSelectCondition: boolArray[index])
        
        addArrangedSubview(view)
    }
}
