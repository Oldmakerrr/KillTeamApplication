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
    
    let headerLabel = UILabel()
    let header = UIView()
    
    let characteristicsView = CharacteristicsView()
    let weaponView = WeaponView()
    
    let abilitiesView = UIView()
    let uniquiActionView = UIView()
    let keywordsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = presenter?.model.choosenUnit?.name
        setupScrollView()
        setupScrollViewContainer()
        setupAdditionalView()
        setupLabelText()
        
    }
}
