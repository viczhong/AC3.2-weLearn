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
        self.contentView.addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { (lbl) in
            lbl.leading.equalToSuperview().offset(10)
            lbl.trailing.equalToSuperview().inset(10)
            lbl.bottom.equalToSuperview()
        }
    }

    lazy var label: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
}
