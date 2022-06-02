//
//  ToastTextView.swift
//  KillTeamApplication
//
//  Created by Apple on 27.05.2022.
//

import UIKit

class ToastTextView: BaseView {
    
    let label = NormalLabel()
    let contentEdgeInsets: UIEdgeInsets
    
    init(message: String,
         contentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
         blureStyle: UIBlurEffect.Style? = nil) {
        self.contentEdgeInsets = contentEdgeInsets
        super.init(blureStyle: blureStyle)
        label.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        label.textAlignment = .center
        //backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.textColor = UIColor.white
        alpha = 1.0
        layer.applyCornerRadius()
        layer.masksToBounds = true
    }
    
    override func setupView() {
        super.setupView()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentEdgeInsets.bottom),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentEdgeInsets.left),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentEdgeInsets.right),
            label.topAnchor.constraint(equalTo: topAnchor, constant: contentEdgeInsets.top)
        ])
    }
}
