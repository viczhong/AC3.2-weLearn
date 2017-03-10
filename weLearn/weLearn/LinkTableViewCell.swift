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
        
        self.backgroundColor = UIColor.weLearnBlue

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
        self.contentView.addSubview(box)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(urlButton)
    }
    
    func setupConstraints() {
        box.snp.makeConstraints { view in
            view.leading.top.equalTo(contentView).offset(7)
            view.trailing.bottom.equalTo(contentView).inset(7)
            view.height.equalTo(75)
        }
        
        authorLabel.snp.makeConstraints { (view) in
            view.top.leading.equalTo(contentView).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { (lbl) in
            lbl.top.equalTo(authorLabel.snp.bottom).offset(10)
            lbl.leading.equalTo(contentView).offset(20)
        }
        
        urlButton.snp.makeConstraints { (pic) in
            pic.width.height.equalTo(40)
            pic.trailing.equalTo(contentView).inset(10)
            pic.bottom.equalTo(contentView).inset(10)
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
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Roman", size: 20)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var authorLabel: UILabel = {
        let lbl = UILabel()
        //lbl.textColor = UIColor.weLearnGrey
        lbl.font = UIFont(name: "Avenir-Black", size: 16)
        return lbl
    }()
    
    lazy var urlButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didClickUrlButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.weLearnBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        return button
    }()

}
