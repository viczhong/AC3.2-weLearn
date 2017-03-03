//
//  DueDatesTableViewCell.swift
//  weLearn
//
//  Created by Cris on 3/1/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class DueDatesTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupHierarchy() {
        self.contentView.addSubview(timerLabel)
        self.contentView.addSubview(assignmentLabel)
    }
    
    func setupConstraints() {
        timerLabel.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(contentView).offset(10)
            lbl.trailing.equalTo(contentView).inset(10)
            lbl.top.equalTo(contentView).offset(10)
            lbl.bottom.equalTo(assignmentLabel.snp.top).inset(-10)
        }
        
        assignmentLabel.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(contentView).offset(10)
            lbl.trailing.equalTo(contentView).inset(10)
            lbl.bottom.equalTo(contentView).inset(10)
        }
    }

    lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Thirtysix", size: 36)
        lbl.textColor = UIColor.weLearnGreen
        lbl.textAlignment = .center
        lbl.layer.shadowColor = UIColor.weLearnBlack.cgColor
        lbl.layer.shadowOffset = CGSize(width: -2, height: 3)
        lbl.layer.shadowOpacity = 3
        lbl.layer.shadowRadius = 1
        lbl.layer.masksToBounds = false
        lbl.numberOfLines = 2
        return lbl
    }()
    
    lazy var assignmentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Black", size: 24)
        lbl.textColor = UIColor.weLearnGreen
        lbl.textAlignment = .center
        lbl.layer.masksToBounds = false
        return lbl
    }()
}
