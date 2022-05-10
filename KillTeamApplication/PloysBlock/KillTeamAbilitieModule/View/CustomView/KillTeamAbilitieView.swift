//
//  KillTeamAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol AbilitieViewProtocol {}

class KillTeamAbilitieView: UIStackView, AbilitieViewProtocol {
    
    weak var viewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = ColorScheme.shared.theme.viewBackground
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRightBurButtonItem(navigationItem: UINavigationItem, image: UIImage?) {
        let button = UIBarButtonItem(image: image,
                                     style: .done,
                                     target: self,
                                     action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonAction() {
    }
    
    func setupDescription(text: String) {
        let view = UIView()
        let label = ItalicLabel()
        label.text = text
        view.addView(view: view, subView: label)
        addArrangedSubview(view)
    }
    
}

