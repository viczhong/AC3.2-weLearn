//
//  AssignmentTableViewCell.swift
//  weLearn
//
//  Created by Marty Avedon on 3/8/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupHierarchy() {
        self.contentView.addSubview(assignmentNameLabel)
        self.contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        assignmentNameLabel.snp.makeConstraints { label in
            label.top.equalTo(contentView).offset(10)
            label.centerX.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints { label in
            label.top.equalTo(assignmentNameLabel.snp.bottom).offset(20)
            label.bottom.equalTo(contentView)
        }
        
    }
    
    lazy var assignmentNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

}
