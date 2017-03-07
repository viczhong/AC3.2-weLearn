//
//  ProfileViewController.swift
//  weLearn
//
//  Created by Marty Avedon on 3/7/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        
        self.view.backgroundColor = UIColor.weLearnLightGreen
        
        viewHeirarchy()
        configureConstraints()
        
        self.edgesForExtendedLayout = .bottom

        // Do any additional setup after loading the view.
    }
    
    func viewHeirarchy() {
        self.view.addSubview(profileBox)
        self.view.addSubview(profilePic)
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(classLabel)
        self.view.addSubview(editButton)
        self.view.addSubview(gradeBox)
        self.view.addSubview(achievementBox)
    }
    
    func configureConstraints() {
        profileBox.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(40)
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
        }
        
        profilePic.snp.makeConstraints { view in
            view.top.leading.equalTo(profileBox).offset(20)
            view.width.equalTo(profileBox).dividedBy(4)
            view.height.equalTo(profilePic.snp.width)
        }
        
        nameLabel.snp.makeConstraints { view in
            view.top.equalTo(profileBox).offset(20)
            view.trailing.equalTo(profileBox).inset(20)
        }
        
        emailLabel.snp.makeConstraints { view in
            view.top.equalTo(nameLabel.snp.bottom).offset(10)
            view.trailing.equalTo(profileBox).inset(20)
        }
        
        classLabel.snp.makeConstraints { view in
            view.top.equalTo(emailLabel.snp.bottom).offset(10)
            view.trailing.equalTo(profileBox).inset(20)
            view.bottom.equalTo(profileBox).inset(20)
        }
        
        achievementBox.snp.makeConstraints { view in
            view.top.equalTo(profileBox.snp.bottom).offset(20)
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
            view.height.equalTo(100)
        }
        
        gradeBox.snp.makeConstraints {view in
            view.top.equalTo(achievementBox.snp.bottom).offset(20)
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
            view.height.equalTo(150)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    lazy var profileBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var profilePic: UIImageView = {
        let pic = UIImageView()
        pic.layer.borderColor = UIColor.black.cgColor
        pic.image = #imageLiteral(resourceName: "profileIcon")
        pic.layer.borderWidth = 5
        return pic
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Karen Fuentes"
        label.font = UIFont(name: "Avenir-LightOblique", size: 20)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "karen@karen.com"
        label.font = UIFont(name: "Avenir-LightOblique", size: 20)
        return label
    }()
    
    lazy var classLabel: UILabel = {
        let label = UILabel()
        label.text = "AC3.2"
        label.font = UIFont(name: "Avenir-LightOblique", size: 20)
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var achievementBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()

    lazy var gradeBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()

}
