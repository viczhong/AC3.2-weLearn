//
//  AnnouncementTableViewCell.swift
//  weLearn
//
//  Created by Cris on 3/1/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import  SnapKit

class AnnouncementTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupToHierachy()
        setupConstraints()
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupToHierachy() {
        self.contentView.addSubview(box)
        self.contentView.addSubview(date)
        self.contentView.addSubview(bar)
        self.contentView.addSubview(quote)
        self.contentView.addSubview(author)
        self.contentView.addSubview(profilePic)
    }
    
    func setupConstraints() {
        box.snp.makeConstraints { (view) in
            view.leading.equalTo(contentView).offset(14)
            view.top.equalTo(contentView).offset(14)
            view.trailing.equalTo(contentView).inset(14)
            view.bottom.equalTo(contentView).inset(14)
        }
        
        date.snp.makeConstraints { (lbl) in
            lbl.top.leading.equalTo(box).offset(10)
        }
        
        quote.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(bar.snp.trailing).offset(10)
            lbl.top.equalTo(date.snp.bottom).offset(10)
            lbl.trailing.equalTo(box).inset(20)
        }
        
        bar.snp.makeConstraints { (view) in
            view.leading.equalTo(box).offset(15)
            view.width.equalTo(2.5)
            view.height.equalTo(quote)
            view.top.equalTo(quote)
        }
        
        author.snp.makeConstraints { (view) in
            view.top.equalTo(quote.snp.bottom).offset(10)
            view.bottom.equalTo(box).inset(10)
            view.trailing.equalTo(box).inset(10)
        }
        profilePic.snp.makeConstraints { (view) in
            view.top.equalTo(quote.snp.bottom).offset(10)
            view.bottom.equalTo(box).inset(10)
            view.trailing.equalTo(author.snp.leading)
            view.width.height.equalTo(50)
        }
    }
    
    lazy var box: Box = {
        let button = Box()
        button.layer.shadowColor = UIColor.weLearnBlue.cgColor
        button.layer.shadowOpacity = 1
        return button
    }()
    
    lazy var date: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont(name: "Avenir-Heavy", size: 20)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    lazy var quote: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 3
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont(name: "Avenir-Light", size: 24)
        return lbl
    }()
    
    lazy var author: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont(name: "Avenir-Heavy", size: 20)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    lazy var bar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnBlue
        return view
    }()
    lazy var profilePic: UIImageView = {
        let pic = UIImageView()
        pic.layer.borderColor = UIColor.weLearnCoolWhite.cgColor
        pic.image = #imageLiteral(resourceName: "user")
        pic.backgroundColor = UIColor.white
        pic.contentMode = .scaleAspectFit
        pic.layer.borderWidth = 3
        return pic
    }()
    
}
