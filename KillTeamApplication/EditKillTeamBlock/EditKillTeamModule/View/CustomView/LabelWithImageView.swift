//
//  CustomNAvigationTitleViewWithImage.swift
//  KillTeamApplication
//
//  Created by Apple on 14.04.2022.
//

import Foundation
import UIKit


class LabelWithImageView: BaseView {
    
    let label = BoldLabel()
    private let imageView = UIImageView()
    
    func setupImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setupText(text: String?) {
        label.text = text
    }
    
    override func configure() {
        super.configure()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
    }
    
    override func setupView() {
        super.setupView()
        addSubview(imageView)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.EdgeInsets.normal)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constant.Size.EdgeInsets.normal),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

