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
        self.view.apply(gradient: [UIColor.weLearnGreen.withAlphaComponent(0.5), .clear])
        viewHiearchy()
        configureConstraints()
    }
    
    func viewHiearchy() {
        self.view.addSubview(logoHeader)
        self.view.addSubview(box)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(usernameStripe)
        self.view.addSubview(usernameBar)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordStripe)
        self.view.addSubview(passwordBar)
        self.view.addSubview(loginButton)
    }
    
    func configureConstraints() {
        logoHeader.snp.makeConstraints { label in
            label.top.equalToSuperview().offset(40)
            label.leading.equalToSuperview().offset(25)
            label.trailing.equalToSuperview().inset(25)
        }
        
        box.snp.makeConstraints { view in
            view.top.equalTo(logoHeader.snp.bottom).offset(20)
            view.centerX.equalToSuperview()
            view.height.equalTo(325)
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
        }
        
        usernameTextField.snp.makeConstraints { view in
            view.top.equalTo(box).offset(60)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        usernameStripe.snp.makeConstraints { view in
            view.width.equalTo(usernameTextField)
            view.trailing.equalTo(usernameTextField)
            view.height.equalTo(2)
            view.top.equalTo(usernameTextField.snp.bottom)
        }
        
        usernameBar.snp.makeConstraints { view in
            view.top.equalTo(usernameTextField)
            view.bottom.equalTo(usernameTextField)
            view.width.equalTo(2)
            view.trailing.equalTo(usernameTextField.snp.trailing)
        }
        
        passwordTextField.snp.makeConstraints { view in
            view.top.equalTo(usernameTextField.snp.bottom).offset(40)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        passwordStripe.snp.makeConstraints { view in
            view.leading.equalTo(passwordTextField)
            view.trailing.equalTo(passwordTextField)
            view.height.equalTo(2)
            view.top.equalTo(passwordTextField.snp.bottom)
        }
        
        passwordBar.snp.makeConstraints { view in
            view.top.equalTo(passwordTextField)
            view.bottom.equalTo(passwordTextField)
            view.width.equalTo(2)
            view.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        loginButton.snp.makeConstraints { button in
            button.top.equalTo(passwordTextField.snp.bottom).offset(40)
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.leading.equalTo(box).offset(15)
            button.trailing.equalTo(box).inset(15)
        }

    }
    
    func loginButtonWasPressed() {
        present(UINavigationController(rootViewController: HomeViewController()), animated: false) {
            print("It worked")
        }
    }
    
    lazy var logoHeader: HeaderLabel = {
        let label = HeaderLabel()
        label.text = "We \nLearn"
        label.font = UIFont(name: "Thirtysix", size: 72)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.white
        label.shadowColor = UIColor.weLearnGreen
        label.shadowOffset = CGSize(width: 10, height: 10)
        return label
    }()
    
    lazy var box: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.weLearnGreen.cgColor
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.weLearnGreen.cgColor
        view.layer.shadowOffset = CGSize(width: -10, height: 10)
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var usernameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "crisChavez@email.com"
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var usernameStripe: UIView = {
        let stripe = UIView()
        stripe.backgroundColor = UIColor.weLearnGreen
        return stripe
    }()
    
    lazy var usernameBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor.weLearnGreen
        return bar
    }()

    lazy var passwordTextField: PaddedTextField = {
        let secondTextField = PaddedTextField()
        secondTextField.placeholder = "password"
        secondTextField.isSecureTextEntry = true
        secondTextField.spellCheckingType = .no
        secondTextField.autocorrectionType = .no
        secondTextField.autocapitalizationType = .none
        return secondTextField
    }()
    
    lazy var passwordStripe: UIView = {
        let secondStripe = UIView()
        secondStripe.backgroundColor = UIColor.weLearnGreen
        return secondStripe
    }()
    
    lazy var passwordBar: UIView = {
        let secondBar = UIView()
        secondBar.backgroundColor = UIColor.weLearnGreen
        return secondBar
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.weLearnGreen
        button.layer.borderColor = UIColor.weLearnGrey.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        return button
    }()
}
