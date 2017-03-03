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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupToHierachy() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(bar)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { view in
            view.leading.equalToSuperview().offset(5)
            view.trailing.equalToSuperview().inset(5)
            view.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { (lbl) in
            lbl.leading.equalTo(bar.snp.trailing).offset(10)
            lbl.trailing.equalToSuperview().inset(10)
            lbl.centerY.equalToSuperview()
        }
        
        bar.snp.makeConstraints { (view) in
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(5)
            view.height.equalTo(label)
            view.top.equalTo(label)
        }
    }
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy var bar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.weLearnGreen
        return view
    }()

}
