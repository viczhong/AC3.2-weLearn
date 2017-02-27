//
//  ShinyOvalButton.swift
//  Vote
//
//  Created by Marty Avedon on 2/26/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ShinyOvalButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let shadowContainerView: UIView = {
            let containerView = UIView()
            containerView.layer.shadowColor = UIColor.weLearnBlack.cgColor
            containerView.layer.shadowOpacity = 0.8
            containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
            containerView.layer.shadowRadius = 5
            containerView.layer.cornerRadius = 15
            return containerView
        }()
        
        self.addSubview(shadowContainerView)
        
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 15
        self.apply(gradient: [UIColor.weLearnGrey.withAlphaComponent(0.01), UIColor.weLearnWarmHighlight])
        self.layer.borderColor = UIColor.weLearnGrey.cgColor
        self.setTitleColor(UIColor.weLearnBlack, for: .normal)
    }
}
