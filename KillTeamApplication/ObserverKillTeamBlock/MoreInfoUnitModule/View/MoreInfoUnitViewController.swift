//
//  MoreInfoUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class MoreInfoUnitViewController: UIViewController, MoreInfoUnitViewControllerProtocol {
    
    var presenter: MoreUnitInfoPresenterProtocol?
    
    let currentWoundLabel = HeaderLabel()
    let characteristicsView = CharacteristicsView()
    
    let stepper = UIStepper()
    
    let scrollView = UIScrollView()
    let scrollViewContainer = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationItem.title = presenter?.model.choosenUnit?.customName ?? ""
        setupScrollView()
        setupScrollViewContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.updateChoosenUnit()
        scrollViewContainer.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        setupAdditionalView()
    }
    
}
