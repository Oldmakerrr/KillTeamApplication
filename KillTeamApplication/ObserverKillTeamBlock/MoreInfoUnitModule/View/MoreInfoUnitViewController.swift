//
//  MoreInfoUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class MoreInfoUnitViewController: UIViewController, MoreInfoUnitViewControllerProtocol {
    
    var presenter: MoreUnitInfoPresenterProtocol?
    
    let scrollView = UIScrollView()
    let scrollViewContainer = UIStackView()
    
    let characteristicsView = CharacteristicsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        title = presenter?.model.choosenUnit?.name
        setupScrollView()
        setupScrollViewContainer()
        setupAdditionalView()
    }
}
