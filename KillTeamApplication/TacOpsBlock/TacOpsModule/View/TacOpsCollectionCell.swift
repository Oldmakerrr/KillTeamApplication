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

protocol TacOpsCollectionCellForInfoDelegate: AnyObject {
    func didSelect(_ cell: TacOpsCollectionCell)
}

protocol TacOpsCollectionCellDelegate: AnyObject {
    func didSelect(_ cell: TacOpsCollectionCell)
}

class TacOpsCollectionCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    let moreInfoButton = UIButton()
    
    let nameLabel = UILabel()
    var tacOp: TacOps?
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        layer.cornerRadius = 12
        setupLabel()
        setupButton()
    }
    
    @objc func selectTacOpMoreInfo() {
        infoDelegate?.didSelect(self)
    }
    
    weak var delegate: TacOpsCollectionCellDelegate?
    weak var infoDelegate: TacOpsCollectionCellForInfoDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupButton() {
        contentView.addSubview(moreInfoButton)
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        moreInfoButton.backgroundColor = .orange
        moreInfoButton.setTitle("More Info", for: .normal)
        moreInfoButton.layer.masksToBounds = true
        moreInfoButton.layer.cornerRadius = 12
        moreInfoButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        moreInfoButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        moreInfoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        moreInfoButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        moreInfoButton.addTarget(self, action: #selector(selectTacOpMoreInfo), for: .touchUpInside)
    }
    
    func setupText(tacOps: TacOps) {
        nameLabel.text = tacOps.name
    }

    
}
