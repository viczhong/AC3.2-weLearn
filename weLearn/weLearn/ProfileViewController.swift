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
            
        }
        
        achievementBox.snp.makeConstraints { view in
        
        }
        
        gradeBox.snp.makeConstraints {view in
        
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
        pic.layer.borderWidth = 5
        return pic
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var classLabel: UILabel = {
        let label = UILabel()
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
