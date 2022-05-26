//
//  UIViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 27.05.2022.
//

import UIKit

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
        let toastView = ToastTextView(message: message)
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
    
    func setupRightNavigationLabel(label: UILabel) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        label.textColor = .white
        navigationBar.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -Constant.Size.Otstup.large)
        ])
    }
    
}
