//
//  PsychicPowerViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 25.04.2022.
//

import UIKit

class PsychicPowerViewController: UIViewController, PsychicPowerViewControllerProtocol {
    
    var presenter: PsychicPowerPresenterProtocol?
    let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    let scrollView = UIScrollView()
    var currentPsychicPowerView = [UIView]()
    let customAlert = CustomScrollAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Psychic Power"
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        setupScrollView()
        setupContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupPsychicPower()
        setupRightBarButtonItems()
    }
    
}

extension PsychicPowerViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
    
}
