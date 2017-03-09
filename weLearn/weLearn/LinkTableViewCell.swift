//
//  LinkTableViewCell.swift
//  weLearn
//
//  Created by Marty Avedon on 3/9/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

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
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(urlButton)
    }
    
    func setupConstraints() {
        authorLabel.snp.makeConstraints { (pic) in
            pic.leading.equalToSuperview()
            pic.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(authorLabel.snp.trailing).offset(10)
            lbl.centerY.equalToSuperview()
        }
        
        urlButton.snp.makeConstraints { (pic) in
            pic.width.height.equalTo(44)
            pic.trailing.equalToSuperview()
            pic.centerY.equalToSuperview()
        }

    }
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var authorLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy var urlButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        return button
    }()

}
