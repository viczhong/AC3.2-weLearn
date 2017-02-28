//
//  InitialViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        viewHiearchy()
        configureConstraints()
    }
    
    func viewHiearchy() {
        self.view.addSubview(logoHeader)
        self.view.addSubview(box)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
    }
    
    func configureConstraints() {
        logoHeader.snp.makeConstraints { label in
            label.top.equalToSuperview().offset(40)
            label.leading.equalToSuperview().offset(10)
            //label.height.equalToSuperview().multipliedBy(0.33)
            label.width.equalToSuperview()
        }
        
        box.snp.makeConstraints { view in
            view.top.equalTo(logoHeader.snp.bottom).offset(40)
            view.centerX.equalToSuperview()
            view.height.equalTo(325)
            view.width.equalTo(325)
        }
        
        usernameTextField.snp.makeConstraints { view in
            view.top.equalTo(box).offset(60)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.width.equalTo(300)
        }
        
        passwordTextField.snp.makeConstraints { view in
            view.top.equalTo(usernameTextField.snp.bottom).offset(40)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.width.equalTo(300)
        }
        
        loginButton.snp.makeConstraints { button in
            button.top.equalTo(passwordTextField.snp.bottom).offset(40)
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.width.equalTo(300)
        }

    }
    
    func loginButtonWasPressed() {
        present( UINavigationController(rootViewController: HomeViewController()), animated: true) {
            print("It worked")
        }
    }
    
    lazy var logoHeader: HeaderLabel = {
        let label = HeaderLabel()
        label.text = "We Learn"
        label.font = UIFont(name: "Thirtysix", size: 72)
        label.textColor = UIColor.white
        label.shadowColor = UIColor.weLearnGreen
        label.shadowOffset = CGSize(width: -10, height: 10)
        return label
    }()
    
    lazy var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.weLearnGreen.cgColor
        view.layer.shadowOffset = CGSize(width: -10, height: 10)
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var usernameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "UserName@email.com"
        return textField
    }()
    
    lazy var passwordTextField: PaddedTextField = {
        let secondTextField = PaddedTextField()
        secondTextField.placeholder = "password"
        return secondTextField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.weLearnGreen
        button.layer.borderColor = UIColor.weLearnCoolAccent.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        return button
    }()
}

