//
//  LinkTableViewCell.swift
//  weLearn
//
//  Created by Marty Avedon on 3/9/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {
    
    var delegate: Tappable?
    var indexPath: IndexPath!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupConstraints()
        
        self.contentView.backgroundColor = UIColor.white

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // Action
    
    func didClickUrlButton(_ sender: UIButton) {
        if let unwrapDelegate = delegate {
            unwrapDelegate.cellTapped(cell: self)
        }
    }
    
    func setupHierarchy() {
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(urlButton)
    }
    
    func setupConstraints() {
        authorLabel.snp.makeConstraints { (pic) in
            pic.leading.equalTo(contentView).offset(10)
            pic.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(authorLabel.snp.trailing).offset(10)
            lbl.centerY.equalToSuperview()
        }
        
        urlButton.snp.makeConstraints { (pic) in
            pic.width.height.equalTo(40)
            pic.trailing.equalToSuperview().inset(10)
            pic.centerY.equalToSuperview()
        }

    }
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Roman", size: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var authorLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Roman", size: 16)
        return lbl
    }()
    
    lazy var urlButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.weLearnGreen, for: .normal)
        button.addTarget(self, action: #selector(didClickUrlButton(_:)), for: .touchUpInside)
        button.layer.borderColor = UIColor.weLearnGrey.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        return button
    }()

}
