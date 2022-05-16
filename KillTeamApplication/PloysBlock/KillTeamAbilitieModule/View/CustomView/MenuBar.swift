//
//  MenuBar.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelect(_ menuBar: MenuBar, indexPath: IndexPath)
}

class MenuBar: UIView {
    
    weak var delegate: MenuBarDelegate?
    
    let namesOfCell: [String]
    let cellCount: Int
    
    lazy var collectionView: UICollectionView = {
        let layout = ZoomAndSnapFlowLayout()
        //layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.isPagingEnabled = true
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        return collectionView
    }()
    
    init(namesOfCell: [String]) {
        self.namesOfCell = namesOfCell
        self.cellCount = namesOfCell.count
        super.init(frame: .zero)
        setupBlurView(style: .dark)
        setupCollectionView()
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    //private func setupBlurView() {
    //    if !UIAccessibility.isReduceTransparencyEnabled {
    //        backgroundColor = .clear
    //        let blurEffect = UIBlurEffect(style: .dark)
    //        let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    //        addSubview(blurEffectView)
    //        NSLayoutConstraint.activate([
    //            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
    //            blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
    //            blurEffectView.heightAnchor.constraint(equalTo: heightAnchor)
    //        ])
    //    } else {
    //        backgroundColor = ColorScheme.shared.theme.viewBackground
    //    }
    //}
}

//MARK: Delegates

extension MenuBar: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        cell.label.text = namesOfCell[indexPath.item]
        return cell
    }
    
}

extension MenuBar: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(self, indexPath: indexPath)
    }
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Cell

class BaseCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
    func setupView() {
        
    }
    
}


class MenuCell: BaseCell {
    
    let label = BoldLabel()
    
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? ColorScheme.shared.theme.selectedView : .white
        }
    }
    
    override func configure() {
        super.configure()
        label.textAlignment = .center
        label.textColor = .white
    }
    
    override func setupView() {
        super.setupView()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.normal),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.normal),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
}
