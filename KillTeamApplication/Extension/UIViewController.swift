//
//  UIViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 27.05.2022.
//

import UIKit
import Instructions

extension UIViewController {
    
    func setEmptyState(title: String,
                       message: String? = nil,
                       image: UIImage? = UIImage(named: "emptyTableViewState"),
                       buttonTitle: String? = nil,
                       delegate: TableViewEmptyStateDelegate? = nil) {
        let emptyStateView = TableViewEmptyState(title: title, message: message, image: image, buttonTitle: buttonTitle, delegate: delegate)
        view.addSubview(emptyStateView)
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyStateView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    func restore() {
        view.subviews.forEach { view in
            if view is TableViewEmptyState {
                view.removeFromSuperview()
            }
        }
    }
    
    func showToast(message : String) {
        view.subviews.first(where: { $0 is ToastTextView})?.removeFromSuperview()
        let toastView = ToastTextView(message: message, blureStyle: .dark)
        self.view.addSubview(toastView)
        NSLayoutConstraint.activate([
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
    
    func setupRightNavigationView(view: UIView, toRight rightView: UIView? = nil) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(view)
        view.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor).isActive = true
        if let rightView = rightView {
            view.trailingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
        } else {
            view.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -Constant.Size.EdgeInsets.large).isActive = true
        }
    }
    
    enum PreviewSwipeDirection {
        case left
        case right
    }
    
    func previewSwipeActions(forCellAt indexPath: IndexPath = IndexPath(row: 0, section: 0),
                             message: String = "  Swipe me  ",
                             actionBackgroundColor: UIColor = UIColor.blue,
                             swipeDirection: PreviewSwipeDirection,
                             tableView: UITableView) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let label: UILabel = {
            let label = UILabel(frame: CGRect.zero)
            label.text = message
            label.backgroundColor = actionBackgroundColor
            label.textColor = .white
            return label
        }()
        
        let bestSize = label.sizeThatFits(label.frame.size)
        switch swipeDirection {
        case .left:
            label.frame = CGRect(x: 0, y: 0, width: bestSize.width, height: cell.bounds.height)
        case .right:
            label.frame = CGRect(x: cell.bounds.width - bestSize.width, y: 0, width: bestSize.width, height: cell.bounds.height)
        }
        
        cell.insertSubview(label, belowSubview: cell.contentView)
        
        UIView.animate(withDuration: 0.3, animations: {
            switch swipeDirection {
            case .left:
                cell.transform = CGAffineTransform.identity.translatedBy(x: label.bounds.width, y: 0)
                label.transform = CGAffineTransform.identity.translatedBy(x: -label.bounds.width, y: 0)
            case .right:
                cell.transform = CGAffineTransform.identity.translatedBy(x: -label.bounds.width, y: 0)
                label.transform = CGAffineTransform.identity.translatedBy(x: label.bounds.width, y: 0)
            }
        }) { (finished) in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.4, options: [], animations: {
                cell.transform = CGAffineTransform.identity
                label.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                label.removeFromSuperview()
            })
        }
    }
    
    
    func isCoachMarkShowed() -> Bool {
        guard let viewController = self.description.components(separatedBy: ".").last?.components(separatedBy: ":").first else { return false }
        let key = "Instruction_\(viewController)"
        guard let data = UserDefaults.standard.value(forKey: key) as? Bool else { return false }
        return data
    }
    
    func setCoachMarkStateToShowed() {
        guard let viewController = self.description.components(separatedBy: ".").last?.components(separatedBy: ":").first else { return }
        let key = "Instruction_\(viewController)"
        UserDefaults.standard.set(true, forKey: key)
    }
    
    
    
    func moreInfoWeaponRuleAlert(weaponRule: WeaponSpecialRule) {
        let screenSize: CGRect = UIScreen.main.bounds
        let alert = WeaponRuleAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.weaponRuleView.widthAnchor.constraint(equalToConstant: screenSize.width - 40).isActive = true
        alert.setupText(rule: weaponRule)
        alert.weaponRuleView.doneButton.addTarget(self, action: #selector(dismissMoreInfoWeaponRuleAlert), for: .touchUpInside)
        alert.addAction(UIAlertAction())
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissMoreInfoWeaponRuleAlert() {
        dismiss(animated: true, completion: nil)
    }
    
}
