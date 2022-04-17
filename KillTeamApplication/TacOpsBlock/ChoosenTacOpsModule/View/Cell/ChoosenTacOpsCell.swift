//
//  ChoosenTacOpsCell.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

class ChoosenTacOpsCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    let ProgressTacOplabel = UILabel()
    var tacOpView = MoreInfoTacOp()
    
    func updateCell() {
        tacOpView.removeFromSuperview()
        tacOpView = MoreInfoTacOp()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tacOpView.backgroundColor = .none
        contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
        setupProgressTacOplabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(tacOpView)
        tacOpView.translatesAutoresizingMaskIntoConstraints = false
        tacOpView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tacOpView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tacOpView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupProgressTacOplabel() {
        addSubview(ProgressTacOplabel)
        ProgressTacOplabel.translatesAutoresizingMaskIntoConstraints = false
        ProgressTacOplabel.textAlignment = .center
        ProgressTacOplabel.font = UIFont.boldSystemFont(ofSize: 20)
        ProgressTacOplabel.text = "Tap to card if you complete Tac Op"
        ProgressTacOplabel.topAnchor.constraint(equalTo: tacOpView.bottomAnchor, constant: 10).isActive = true
        ProgressTacOplabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        ProgressTacOplabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        //ProgressTacOplabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
