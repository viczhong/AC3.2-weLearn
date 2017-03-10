//
//  AssignmentTableViewCell.swift
//  weLearn
//
//  Created by Marty Avedon on 3/8/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class AssignmentTableViewCell: UITableViewCell {
    
    var delegate: Tappable?
    var indexPath: IndexPath!
    
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
    
    // Action
    
    func didClickRepoButton(_ sender: UIButton) {
        if let unwrapDelegate = delegate {
            unwrapDelegate.cellTapped(cell: self)
        }
    }
    
    func setupHierarchy() {
        self.contentView.addSubview(box)
        self.contentView.addSubview(assignmentNameLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(topHorizontalRule)
        self.contentView.addSubview(bottomHorizontalRule)
        self.contentView.addSubview(gradeLabel)
        self.contentView.addSubview(gradeSquare)
        self.contentView.addSubview(repoLink)
    }
    
    func setupConstraints() {
        box.snp.makeConstraints { (view) in
            view.leading.equalTo(contentView).offset(7)
            view.top.equalTo(contentView).offset(7)
            view.trailing.equalTo(contentView).inset(7)
            view.bottom.equalTo(contentView).inset(7)
        }
        
        assignmentNameLabel.snp.makeConstraints { label in
            label.top.equalTo(box).offset(10)
            label.centerX.equalTo(box)
        }
        
        dateLabel.snp.makeConstraints { label in
            label.top.equalTo(assignmentNameLabel.snp.bottom).offset(20)
            label.leading.equalTo(box).offset(10)
        }
        
        gradeLabel.snp.makeConstraints { label in
            label.center.equalTo(gradeSquare)
        }
        
        gradeSquare.snp.makeConstraints { view in
            view.height.width.equalTo(33)
            view.centerY.equalTo(dateLabel)
            view.trailing.equalTo(box).inset(10)
        }
        
        repoLink.snp.makeConstraints { view in
            view.top.equalTo(gradeSquare.snp.bottom).offset(20)
            view.width.equalTo(box)
            view.height.equalTo(44)
            view.centerX.equalTo(box)
            view.bottom.equalTo(box).inset(10)
        }
        
        topHorizontalRule.snp.makeConstraints { view in
            view.height.equalTo(1)
            view.width.equalTo(box)
            view.centerY.equalTo(gradeSquare.snp.top)
            view.centerX.equalTo(box)
        }
        
        bottomHorizontalRule.snp.makeConstraints { view in
            view.height.equalTo(1)
            view.width.equalTo(box)
            view.centerY.equalTo(gradeSquare.snp.bottom)
            view.centerX.equalTo(box)
        }
        
    }
    
    lazy var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnCoolWhite
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.75
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var assignmentNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 30)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 16)
        return label
    }()
    
    lazy var gradeSquare: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnGreen.withAlphaComponent(0.5)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var gradeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 16)
        return label
    }()
    
    lazy var repoLink: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        button.addTarget(self, action: #selector(didClickRepoButton(_:)), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 2
        return button
    }()
    
    lazy var topHorizontalRule: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnGrey
        return view
    }()
    
    lazy var bottomHorizontalRule: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnGrey
        return view
    }()
    
}
