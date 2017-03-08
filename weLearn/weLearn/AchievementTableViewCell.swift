//
//  AchievementTableViewCell.swift
//  weLearn
//
//  Created by Marty Avedon on 3/8/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

// *** This is a container for the achievements -- see the collection view for cell details 

class AchievementTableViewCell: UITableViewCell {

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
        self.contentView.addSubview(box)
        self.contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        box.snp.makeConstraints { (view) in
            view.leading.equalTo(contentView).offset(7)
            view.top.equalTo(contentView).offset(7)
            view.trailing.equalTo(contentView).inset(7)
            view.bottom.equalTo(contentView).inset(7)
        }
        
        collectionView.snp.makeConstraints { view in
            view.top.leading.equalTo(box)
            view.bottom.trailing.equalTo(box)
        }
    }
    
    lazy var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
}
