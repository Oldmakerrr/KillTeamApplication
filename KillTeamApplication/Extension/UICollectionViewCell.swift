//
//  UICollectionViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 29.07.2022.
//

import UIKit

extension UICollectionViewCell {
    
    func swipeAnimate(duration: CFTimeInterval = 0.8, pathLength: CGFloat = 50) {
        let position: CGPoint = self.center
        let path: UIBezierPath = UIBezierPath()
        path.move(to:CGPoint(x:position.x, y:position.y))
        path.addLine(to:CGPoint(x:position.x-pathLength, y:position.y))
        path.addLine(to:CGPoint(x:position.x, y:position.y))
    

        let positionAnimation = CAKeyframeAnimation(keyPath: "position")

        positionAnimation.path = path.cgPath
        positionAnimation.duration = duration
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
    }
}
