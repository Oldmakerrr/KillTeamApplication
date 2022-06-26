//
//  TableViewEmptyState.swift
//  KillTeamApplication
//
//  Created by Apple on 27.05.2022.
//

import UIKit

protocol TableViewEmptyStateDelegate: AnyObject {
    func didComplete(_ tableViewEmptyState: TableViewEmptyState)
}

class TableViewEmptyState: BaseView {
    
    weak var delegate: TableViewEmptyStateDelegate?
    
    let titleLabel = BoldLabel()
    let messageLabel = NormalLabel()
    let imageView = UIImageView()
    let button = UIButton()
    
    private let title: String?
    private let message: String?
    private let image: UIImage?
    @objc private let buttonTitle: String?
    
    init(title: String,
         message: String?,
         image: UIImage?,
         buttonTitle: String?,
         delegate: TableViewEmptyStateDelegate?,
         blureStyle: UIBlurEffect.Style? = nil) {
        self.title = title
        self.message = message
        self.image = image
        self.buttonTitle = buttonTitle
        self.delegate = delegate
        super.init(blureStyle: blureStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .clear
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.textAlignment = .center
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2427081466, green: 0.2497632205, blue: 0.3120179176, alpha: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.applyCornerRadius()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    override func setupView() {
        super.setupView()
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: self)
        if message != nil {
            addSubview(messageLabel)
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
        
        if image != nil {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        
        if buttonTitle != nil {
            addSubview(button)
            if message != nil {
                button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            }
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                button.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 30)
            ])
            button.centerX(inView: self)
        }
        
    }
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
}
