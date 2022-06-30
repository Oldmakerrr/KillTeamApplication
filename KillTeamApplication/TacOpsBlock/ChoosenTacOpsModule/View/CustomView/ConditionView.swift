//
//  ConditionView.swift
//  KillTeamApplication
//
//  Created by Apple on 24.04.2022.
//

import Foundation
import UIKit

class ConditionView: UIView {
    
    private let imageView = UIImageView()
    private let label = NormalLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "square")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(text: String) {
        label.text = text
    }
    
    func setupImage(image: UIImage?) {
        imageView.image = image
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constant.Size.EdgeInsets.small),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.EdgeInsets.normal),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.EdgeInsets.small),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.EdgeInsets.small)
        ])

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -Constant.Size.EdgeInsets.small),
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: label.font.pointSize + 4),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
