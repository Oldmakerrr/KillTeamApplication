//
//  TacOpsCollectionCell.swift
//  KillTeamApplication
//
//  Created by Apple on 20.02.2022.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

protocol TacOpsCollectionCellButtonDelegate: AnyObject {
    func didSelect(_ cell: TacOpsCollectionCell)
}

protocol TacOpsCollectionCellDelegate: AnyObject {
    func didSelect(_ cell: TacOpsCollectionCell)
}

class TacOpsCollectionCell: UICollectionViewCell, ReusableView {
    
    weak var delegate: TacOpsCollectionCellDelegate?
    weak var buttonDelegate: TacOpsCollectionCellButtonDelegate?
    
    static var identifier: String {
        String(describing: self)
    }
    
    let button = DoneButton()
    let nameLabel = HeaderLabel()
    
    var tacOp: TacOps?
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.applySketchShadow()
        layer.applyCornerRadius()
        layer.masksToBounds = true
        setupLabel()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupColor(tacOp: TacOps?) {
        if self.tacOp == tacOp {
            contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
        } else {
            contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        }
    }
    
    func setupText(tacOps: TacOps) {
        nameLabel.text = tacOps.name
    }
    
    private func setupLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.normal),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.normal),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.Otstup.normal),
        ])
        
    }
    
    @objc func buttonAction() {
        buttonDelegate?.didSelect(self)
    }
    
    private func setupButton() {
        contentView.addSubview(button)
        button.setTitle("More Info", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: Constant.Size.Otstup.normal),
            button.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.normal),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
    }
    
    
}
