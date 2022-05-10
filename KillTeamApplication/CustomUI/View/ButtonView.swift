//
//  ButtonView.swift
//  KillTeamApplication
//
//  Created by Apple on 06.05.2022.
//

import UIKit

class ButtonView: BaseView {
    
    let button: UIButton
    let width: CGFloat
    let height: CGFloat
    
    init(button: UIButton, width: CGFloat, height: CGFloat) {
        self.button = button
        self.width = width
        self.height = height
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupView() {
        super.setupView()
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

