//
//  InitialViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        viewHiearchy()
        configureConstraints()
    }
    
    
    func viewHiearchy() {
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
    }
    
    func configureConstraints() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16.0).isActive = true
        
        
        passwordTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0).isActive = true
        
        
    }
    func loginButtonWasPressed() {
        present( UINavigationController(rootViewController: HomeViewController()), animated: true) {
            print("It worked")
        }
    }
    
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let secondTextField = UITextField()
        return secondTextField
    }()
    
    lazy var loginButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        return button
    }()
}

