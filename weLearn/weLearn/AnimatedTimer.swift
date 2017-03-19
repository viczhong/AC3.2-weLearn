//
//  AnimatedTimer.swift
//  weLearn
//
//  Created by Marty Avedon on 3/18/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class AnimatedTimer: UIView, CAAnimationDelegate {

    var elapsedTime: CAShapeLayer!
    var timeToGo: CAShapeLayer!
    var watchFace: UIView!
    var watchHand: UIView!
    var deadline: CGFloat = 1
    var duration: Int = 1

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.white
        
        self.timeToGo = CAShapeLayer()
        timeToGo.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).cgPath
        timeToGo.strokeColor = UIColor.gray.cgColor
        timeToGo.lineWidth = 6
        timeToGo.fillColor = UIColor.clear.cgColor
        timeToGo.strokeStart = 0
        timeToGo.strokeEnd = 1
        
        self.elapsedTime = CAShapeLayer()
        elapsedTime.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).cgPath
        // C4Q green 
        elapsedTime.strokeColor = UIColor(red:0.42, green:0.78, blue:0.15, alpha:1.0).cgColor
        elapsedTime.lineWidth = 6
        elapsedTime.fillColor = UIColor.clear.cgColor
        elapsedTime.strokeStart = 0
        elapsedTime.strokeEnd = 0
        
        self.watchHand = UIView()
        self.watchHand.backgroundColor = UIColor.weLearnBlack
        
        self.watchFace = UIView()
        
        self.layer.addSublayer(timeToGo)
        self.layer.addSublayer(elapsedTime)
        self.watchFace.addSubview(watchHand)
        self.addSubview(watchFace)
        
        self.watchFace.snp.makeConstraints { view in
            view.width.height.equalToSuperview()
            view.center.equalToSuperview()
        }
        
        self.watchHand.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(5)
            view.width.equalTo(2)
            view.bottom.equalToSuperview().inset(22)
            view.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(towardsDeadline: CGFloat, forDuration: Int) {
        let animationForStroke = CABasicAnimation(keyPath: "strokeEnd")
        animationForStroke.duration = 5
        animationForStroke.delegate = self
        
        animationForStroke.fromValue = 0
        animationForStroke.toValue = towardsDeadline
        
        elapsedTime.strokeEnd = towardsDeadline
        elapsedTime.add(animationForStroke, forKey: "strokeEnd")
        
        animateWatchHand()
    }
    
    func animateWatchHand() {
        // keyframes to spin
        
        let fullRotation = CGFloat.pi * 2
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat, .calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.watchFace?.transform = CGAffineTransform(rotationAngle: 1/3 * fullRotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.watchFace?.transform = CGAffineTransform(rotationAngle: 2/3 * fullRotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.watchFace?.transform = CGAffineTransform(rotationAngle: 3/3 * fullRotation)

            })
            }, completion: nil
        )
    }
}
