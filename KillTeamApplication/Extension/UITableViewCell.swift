//
//  UITableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 27.05.2022.
//

import UIKit
import QuartzCore

extension UITableViewCell {
    func shake(duration: CFTimeInterval = 0.2, pathLength: CGFloat = 12) {
        let position: CGPoint = self.center
        let path: UIBezierPath = UIBezierPath()
        path.move(to:CGPoint(x:position.x, y:position.y))
        path.addLine(to:CGPoint(x:position.x-pathLength, y:position.y))
        path.addLine(to:CGPoint(x:position.x+pathLength, y:position.y))
        path.addLine(to:CGPoint(x:position.x-pathLength/2, y:position.y))
        path.addLine(to:CGPoint(x:position.x+pathLength/2, y:position.y))
        path.addLine(to:CGPoint(x:position.x, y:position.y))

        let positionAnimation = CAKeyframeAnimation(keyPath: "position")

        positionAnimation.path = path.cgPath
        positionAnimation.duration = duration
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
    }
}
