//
//  PathfinderAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class PathfinderAbilitieView: KillTeamAbilitieView {
    
    func setupAbilitieText(abilitie: PathfinderAbilitie.Abilitie) {
        setupHeader(title: abilitie.name)
        switch abilitie.name {
        case "ARTIFICIAL INTELLIGENCE":
            addSubTextPointView(subText: abilitie.rules)
        default:
            abilitie.rules.forEach { text in
                setupTextView(text: text)
            }
        }
        
    }
    
    func setupMarkerlightRule(markerRule: PathfinderAbilitie.MarkerlightRule, delegate: WeaponRuleButtonDelegate) {
        setupHeader(title: markerRule.name)
        setupDescription(text: markerRule.description)
        setupUniqueActionView(markerRule: markerRule, delegate: delegate)
        markerRule.rules.forEach { text in
            setupTextView(text: text)
        }
        for (index, benefit) in markerRule.markerlightBenefit.enumerated() {
            let view = MarkerlightBenefitView()
            view.backgroundColor = index % 2 == 0 ? ColorScheme.shared.theme.subViewBackground : ColorScheme.shared.theme.viewBackground
            view.setupBenefit(benefit: benefit, cost: index+1)
            addArrangedSubview(view)
        }
    }
    
    func setupArtOfWarRule(artOfWarRule: PathfinderAbilitie.ArtOfWarRule) {
        setupHeader(title: artOfWarRule.name)
        setupDescription(text: artOfWarRule.description)
        setupTextView(text: artOfWarRule.rule)
        artOfWarRule.artsOfWar.forEach { rule in
            let backgroundView = UIView()
            let view = ArtOfWarView()
            view.setupText(abilitie: rule)
            backgroundView.addView(view: backgroundView, subView: view)
            addArrangedSubview(backgroundView)
        }
    }
    
    private func setupUniqueActionView(markerRule: PathfinderAbilitie.MarkerlightRule, delegate: WeaponRuleButtonDelegate) {
        let backgroundView = UIView()
        let view = UniqueActionView()
        view.layer.applyBorder()
        backgroundView.addView(view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.setupText(action: markerRule.uniqueAction, delegate: delegate, viewWidth: view.getViewWidth())
    }
}

class MarkerlightBenefitView: UIStackView {
    
    let costView = ViewWithLabel()
    let benefitView = ViewWithLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBenefit(benefit: String, cost: Int) {
        benefitView.setupText(text: benefit)
        costView.setupText(text: "\(cost)+")
    }
    
    private func setupView() {
        addArrangedSubview(costView)
        addArrangedSubview(benefitView)
    }
}

//MARK: - ArtOfWarView

class ArtOfWarView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.applyBorder()
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(abilitie: PathfinderAbilitie.Abilitie) {
        setupHeader(title: abilitie.name)
        abilitie.rules.forEach { text in
            setupTextView(text: text)
        }
    }
}