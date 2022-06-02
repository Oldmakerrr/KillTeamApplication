//
//  CounterPointView.swift
//  KillTeamApplication
//
//  Created by Apple on 01.05.2022.
//

import UIKit


protocol CounterPointViewDelegate: AnyObject {
    func didComplete(_ counterPointView: CounterPointView, sender: UIButton)
}

class CounterPointView: BaseView {
    
    weak var delegate: CounterPointViewDelegate?
    
    var title: String
    
    init(title: String, blureStyle: UIBlurEffect.Style? = nil) {
        self.title = title
        super.init(blureStyle: blureStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = CounterLabel()
    let plusButton = ChangePointButtonN(imageName: "arrowtriangle.right.fill")
    let minusButton = ChangePointButtonN(imageName: "arrowtriangle.left.fill")
    
    override func setupView() {
        super.setupView()
        addSubview(plusButton)
        addSubview(label)
        addSubview(minusButton)
        NSLayoutConstraint.activate([
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.topAnchor.constraint(equalTo: topAnchor),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            minusButton.trailingAnchor.constraint(lessThanOrEqualTo: label.leadingAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(greaterThanOrEqualTo: minusButton.trailingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: plusButton.leadingAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            plusButton.topAnchor.constraint(equalTo: topAnchor),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor)
        ])
    }
    
    @objc private func buttonAction(sender: UIButton) {
        delegate?.didComplete(self, sender: sender)
    }
    
    override func configure() {
        super.configure()
       // plusButton.setupImage(imageName: "plus")
       // minusButton.setupImage(imageName: "minus")
        label.text = "\(title) = 0"
        label.textAlignment = .center
        minusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
}
