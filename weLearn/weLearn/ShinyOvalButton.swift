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
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
//        self.apply(gradient: [UIColor.weLearnBlue.withAlphaComponent(0.1), UIColor.white, UIColor.weLearnBlue.withAlphaComponent(0.1)])
        self.layer.borderColor = UIColor.weLearnBlue.cgColor
        self.setTitleColor(UIColor.weLearnBlue, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Black", size: 12)
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowRadius = 2
    }
}
