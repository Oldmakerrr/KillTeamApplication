//
//  TableHeaderView.swift
//  KillTeamApplication
//
//  Created by Apple on 05.07.2022.
//

import UIKit

class TableHeaderView: UIView {
    
    let label = HeaderLabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorScheme.shared.theme.viewHeader
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        addSubview(label)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.EdgeInsets.large),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.EdgeInsets.large)
        ])
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constant.Size.EdgeInsets.large),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constant.Size.EdgeInsets.large),
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
