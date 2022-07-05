//
//  ChosenTacOpsCell.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

class ChosenTacOpsCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    let scrollView = UIScrollView()
    
    var tacOpView = ChosenTacOpView()
    
    let header = HeaderView()
    
    func updateCell() {
        tacOpView.removeFromSuperview()
        tacOpView = ChosenTacOpView()
        tacOpView.backgroundColor = .none
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.applyCornerRadius()
        layer.masksToBounds = true
        contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        setupScrollView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(tacOp: TacOp, delegate: WeaponRuleButtonDelegate, conditionViewDelegate: ChosenTacOpViewDelegate) {
        header.setupText(name: tacOp.name)
        tacOpView.conditionViewDelegate = conditionViewDelegate
        tacOpView.setupText(tacOp: tacOp, delegate: delegate)
    }
    
    func setupScrollView() {
        addSubview(header)
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.bottomAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func setupView() {
        scrollView.addSubview(tacOpView)
        NSLayoutConstraint.activate([
            tacOpView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tacOpView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tacOpView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tacOpView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tacOpView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
}
