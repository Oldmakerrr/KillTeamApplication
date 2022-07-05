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
    
    let moreInfoButton = InfoButton()
    let nameLabel = BoldLabel()
    let imageView = UIImageView()
    
    var tacOp: TacOp?
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.applySketchShadow()
        layer.applyCornerRadius()
        layer.masksToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenHeight * 0.018)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setupLabel()
        setupButton()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupColor(tacOp: TacOp?) {
        if self.tacOp == tacOp {
            contentView.alpha = 1
            contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
            transform = CGAffineTransform(scaleX: 1.025, y: 1.025)
        } else {
            contentView.alpha = 0.8
            transform = CGAffineTransform(scaleX: 0.975, y: 0.975)
            contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        }
    }
    
    func setupText(tacOps: TacOp) {
        nameLabel.text = tacOps.name
    }
    
    private func setupLabel() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.normal),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.EdgeInsets.normal),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal),
            nameLabel.heightAnchor.constraint(equalToConstant: Constant.Size.screenHeight * 0.050),
            nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor)
        ])
        
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "KILL_TEAM")
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -Constant.Size.screenHeight * 0.0115),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        
    }
    
    @objc func buttonAction() {
        buttonDelegate?.didSelect(self)
    }
    
    private func setupButton() {
        contentView.addSubview(moreInfoButton)
        moreInfoButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            moreInfoButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            moreInfoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            moreInfoButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            moreInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.EdgeInsets.small),
            moreInfoButton.widthAnchor.constraint(equalToConstant: 30),
            moreInfoButton.heightAnchor.constraint(equalTo: moreInfoButton.widthAnchor)
        ])
    }
    
    
}
