//
//  TextView.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

class BaseView: UIView {
    
    var blureStyle: UIBlurEffect.Style?
    
    init(blureStyle: UIBlurEffect.Style? = nil) {
        super.init(frame: .zero)
        self.blureStyle = blureStyle
        configure()
        setupView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        if let blureStyle = blureStyle {
            setupBlurView(style: blureStyle)
        }
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class ViewWithLabel: BaseView {
    
    let label: UILabel
    private let otstup = Constant.Size.EdgeInsets.normal
    
    init(label: UILabel = NormalLabel(), blureStyle: UIBlurEffect.Style? = nil) {
        self.label = label
        super.init(blureStyle: blureStyle)
    }
    
    func setupText(text: String) {
        label.text = text
    }
    
    override func setupView() {
        super.setupView()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: otstup),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: otstup),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -otstup),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -otstup),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
