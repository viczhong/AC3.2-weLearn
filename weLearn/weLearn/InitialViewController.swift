//
//  InitialViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class InitialViewController: UIViewController {
    
    var databaseReference = FIRDatabase.database()
    var databaseObserver: FIRDatabaseHandle?
    var signedInUser: FIRUser?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.apply(gradient: [UIColor.weLearnGreen.withAlphaComponent(0.5), UIColor.weLearnGreen.withAlphaComponent(0.75)])
        viewHiearchy()
        configureConstraints()
    }
    
    func viewHiearchy() {
        self.view.addSubview(logoPic)
        self.view.addSubview(logoHeader)
        self.view.addSubview(box)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(usernameStripe)
        self.view.addSubview(usernameBar)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordStripe)
        self.view.addSubview(passwordBar)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    
    func configureConstraints() {
        logoPic.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(30)
            view.leading.equalTo(logoHeader.snp.trailing).inset(10)
        }
        
        logoHeader.snp.makeConstraints { label in
            label.top.equalToSuperview().offset(40)
            label.leading.equalToSuperview().offset(25)
        }
        
        box.snp.makeConstraints { view in
            view.top.equalTo(logoHeader.snp.bottom).offset(20)
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
        }
        
        usernameTextField.snp.makeConstraints { view in
            view.top.equalTo(box).offset(40)
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
            view.leading.equalTo(usernameTextField)
        }
        
        passwordTextField.snp.makeConstraints { view in
            view.top.equalTo(usernameTextField.snp.bottom).offset(20)
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
            view.leading.equalTo(passwordTextField)
        }
        
        loginButton.snp.makeConstraints { button in
            button.top.equalTo(passwordTextField.snp.bottom).offset(40)
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.leading.equalTo(box).offset(15)
            button.trailing.equalTo(box).inset(15)
        }
        
        registerButton.snp.makeConstraints { button in
            button.top.equalTo(loginButton.snp.bottom).offset(20)
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.bottom.equalTo(box).inset(40)
            button.leading.equalTo(box).offset(15)
            button.trailing.equalTo(box).inset(15)
        }
        
    }
    
    func signInCredentials() -> (name: String, email: String, password: String, studentClass: String, studentID: String)? {
        guard let password = passwordTextField.text,
            let email = usernameTextField.text else { return nil }
        return ("Cris", email, password, "Accesscode", "3204")
    }
    
    func showAlert(title: String, _ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpDatabaseReference() {
        guard let credentials = signInCredentials() else { return }
        
        let referenceLink = databaseReference.reference().child(credentials.studentClass).childByAutoId()
        
        let dict = [
            "studentName" : credentials.name,
            "studentEmail" : credentials.email,
            "class" : credentials.studentClass,
            "studentID" : credentials.studentID
        ]
        
        referenceLink.setValue(dict)
    }
    
    func loginButtonWasPressed() {
        guard let credentials = signInCredentials() else { return }
        FIRAuth.auth()?.signIn(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
            
            if user != nil {
                
                self.present(UINavigationController(rootViewController: HomeViewController()), animated: false)
            }
            
            if let error = error {
                self.showAlert(title: "Login error", error.localizedDescription)
            }
            
        })
    }
    
    func registerButtonWasPressed() {
        guard let credentials = signInCredentials() else { return }
        FIRAuth.auth()?.createUser(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
            if user != nil {
                self.signedInUser = user
                self.setUpDatabaseReference()
                self.registerButton.isEnabled = false
                self.registerButton.alpha = 0.50
            }
            if let error = error {
                self.showAlert(title: "Registering Error", error.localizedDescription)
            }
        })
        //present(UINavigationController(rootViewController: RegistrationViewController()), animated: false)
    }
    
    lazy var logoPic: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logoForHeader")
        view.layer.shadowColor = UIColor.weLearnGreen.cgColor
        view.layer.shadowOffset = CGSize(width: -10, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var logoHeader: UIOutlinedLabel = {
        let label = UIOutlinedLabel()
        label.text = "We \nLearn"
        label.font = UIFont(name: "Thirtysix", size: 72)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.weLearnGreen.cgColor
        label.layer.shadowOffset = CGSize(width: -10, height: 10)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 1
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var usernameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Email"
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
        secondTextField.placeholder = "Password"
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
        button.backgroundColor = UIColor.weLearnCoolWhite
        button.layer.borderColor = UIColor.weLearnGreen.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitle("Login".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnGreen, for: .normal)
        button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.weLearnCoolWhite
        button.layer.borderColor = UIColor.weLearnGreen.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitle("register".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnGreen, for: .normal)
        button.addTarget(self, action: #selector(registerButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
}
