//
//  CustomNAvigationTitleViewWithImage.swift
//  KillTeamApplication
//
//  Created by Apple on 14.04.2022.
//

import Foundation
import UIKit


class LabelWithImageView: UIView {
    
    private let label = NormalLabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setupText(text: String?) {
        label.text = text
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
    }
    
    private func addConstraints() {
        addSubview(imageView)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.Otstup.normal)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constant.Size.Otstup.normal),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

