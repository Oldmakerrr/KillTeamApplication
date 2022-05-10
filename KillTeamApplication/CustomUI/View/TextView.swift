//
//  TextView.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class ViewWithLabel: BaseView {
    
    private let label: UILabel
    private let otstup = Constant.Size.Otstup.normal
    
    init(label: UILabel = NormalLabel()) {
        self.label = label
        super.init(frame: .zero)
    }
    
    func setupText(text: String) {
        label.text = text
    }
    
    override func setupView() {
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
