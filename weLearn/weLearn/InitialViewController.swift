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

class InitialViewController: UIViewController, UITextFieldDelegate {
    
    var databaseReference: FIRDatabaseReference!
    var databaseObserver: FIRDatabaseHandle?
    var signedInUser: FIRUser?
    
    var toggleIsHiddenWhenTabIsChanged = [UIView]()
    
    // Timer stuff for buttons
    
    var time = 0.0
    var timer: Timer!
    var selection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view.apply(gradient: [UIColor.white, UIColor(red:0.30, green:0.51, blue:0.69, alpha:1.0).withAlphaComponent(0.5), UIColor(red:0.30, green:0.51, blue:0.69, alpha:1.0)])
        self.view.apply(gradient: [UIColor.weLearnBlue, UIColor.weLearnBlue.withAlphaComponent(0.75)])
        
        self.passwordTextField.delegate = self
        
        viewHiearchy()
        configureConstraints()
        
        registerTab.backgroundColor = UIColor.weLearnLightGreen
        
        toggleIsHiddenWhenTabIsChanged = [
            registerButton,
            nameTextField,
            classTextField,
            studentIDTextField
        ]
        
        toggleIsHiddenWhenTabIsChanged.map { $0.isHidden = true }
        databaseReference = FIRDatabase.database().reference()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            self.view.endEditing(true)
            self.loginButtonWasPressed()
        }
        return true
    }
    
    
    
    func checkLogin() {
        if FIRAuth.auth()?.currentUser != nil {
            self.present(UINavigationController(rootViewController: HomeViewController()), animated: false)
        }
    }
    
    func colorTab(button1: UIButton, button2: UIButton) {
        if button1.isSelected {
            button1.backgroundColor = UIColor.white
            button2.backgroundColor = UIColor.weLearnLightGreen
        } else {
            button1.backgroundColor = UIColor.weLearnLightGreen
            button2.backgroundColor = UIColor.white
        }
    }
    
    func viewHiearchy() {
        self.view.addSubview(logoPic)
        self.view.addSubview(logoOverlay)
        // self.view.addSubview(logoHeader)
        self.view.addSubview(registerTab)
        self.view.addSubview(registerTabLabel)
        self.view.addSubview(loginTab)
        self.view.addSubview(loginTabLabel)
        self.view.addSubview(box)
        self.view.addSubview(nameTextField)
        self.view.addSubview(classTextField)
        self.view.addSubview(studentIDTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    
    func configureConstraints() {
        logoPic.snp.makeConstraints { view in
            view.width.equalToSuperview().dividedBy(2)
            view.height.equalToSuperview().dividedBy(5)
            view.top.equalToSuperview().offset(30)
            view.centerX.equalToSuperview()
        }
        
        logoOverlay.snp.makeConstraints { view in
            view.width.equalToSuperview().dividedBy(2)
            view.height.equalToSuperview().dividedBy(5)
            view.top.equalToSuperview().offset(30)
            view.centerX.equalToSuperview().offset(5)
        }
        
        //        logoHeader.snp.makeConstraints { label in
        //            label.top.equalToSuperview().offset(40)
        //            label.leading.equalToSuperview().offset(25)
        //        }
        
        box.snp.makeConstraints { view in
            view.top.equalTo(logoPic.snp.bottom).offset(60)
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview().offset(25)
            view.trailing.equalToSuperview().inset(25)
        }
        
        loginTab.snp.makeConstraints { view in
            view.bottom.equalTo(box.snp.top)
            view.leading.equalTo(box)
            view.width.equalTo(box).dividedBy(2)
            view.height.equalTo(40)
        }
        
        loginTabLabel.snp.makeConstraints { view in
            view.center.equalTo(loginTab)
        }
        
        registerTab.snp.makeConstraints { view in
            view.bottom.equalTo(box.snp.top)
            view.trailing.equalTo(box)
            view.width.equalTo(box).dividedBy(2)
            view.height.equalTo(40)
        }
        
        registerTabLabel.snp.makeConstraints { view in
            view.center.equalTo(registerTab)
        }
        
        // visible on login & registration tab
        
        emailTextField.snp.makeConstraints { view in
            view.top.equalTo(box).offset(40)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        passwordTextField.snp.makeConstraints { view in
            view.top.equalTo(emailTextField.snp.bottom).offset(10)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        loginButton.snp.makeConstraints { button in
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.leading.equalTo(box).offset(15)
            button.trailing.equalTo(box).inset(15)
            button.centerY.equalTo(registerButton)
        }
        
        // visible on registration tab only
        
        nameTextField.snp.makeConstraints { view in
            view.top.equalTo(passwordTextField.snp.bottom).offset(10)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        studentIDTextField.snp.makeConstraints { view in
            view.top.equalTo(nameTextField.snp.bottom).offset(10)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        classTextField.snp.makeConstraints { view in
            view.top.equalTo(studentIDTextField.snp.bottom).offset(10)
            view.centerX.equalToSuperview()
            view.height.equalTo(40)
            view.leading.equalTo(box).offset(15)
            view.trailing.equalTo(box).inset(15)
        }
        
        registerButton.snp.makeConstraints { button in
            button.top.equalTo(classTextField.snp.bottom).offset(40)
            button.centerX.equalToSuperview()
            button.height.equalTo(40)
            button.leading.equalTo(box).offset(15)
            button.trailing.equalTo(box).inset(15)
            button.bottom.equalTo(box).inset(40)
        }
    }
    
    // MARK: - Button Actions
    
    func signInCredentials() -> (name: String, email: String, password: String, studentClass: String, studentID: String)? {
        guard let password = passwordTextField.text,
            let email = emailTextField.text,
            let name = nameTextField.text,
            let studentClass = classTextField.text,
            let studentID = studentIDTextField.text else { return nil }
        return (name, email, password, studentClass, studentID)
    }
    
    func showAlert(title: String, _ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpDatabaseReference() {
        guard let credentials = signInCredentials() else { return }
        
        
        let referenceLink = databaseReference.child("users").child("\(FIRAuth.auth()!.currentUser!.uid)")
        
        let dict = [
            "studentName" : credentials.name,
            "studentEmail" : credentials.email,
            "class" : credentials.studentClass,
            "studentID" : credentials.studentID
        ]
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(dict, forKey: "studentInfo")
        
        referenceLink.setValue(dict)
    }
    
    func fillInSingleton(_ string: String) {
        let user = databaseReference.child("users").child(string)
        user.observeSingleEvent(of: .value, with: { (snapshot) in
            if let valueDict = snapshot.value as? [String : Any] {
                let user = User.manager
                user.classroom = valueDict["class"] as? String
                user.email = valueDict["studentEmail"] as? String
                user.id = valueDict["studentID"] as? String
                user.name = valueDict["studentName"] as? String
            }
        })
    }
    
    func loginButtonWasPressed() {
        guard let credentials = signInCredentials() else { return }
        FIRAuth.auth()?.signIn(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
            
            if let loggedInUser = user {
                self.fillInSingleton(loggedInUser.uid)
                self.passwordTextField.text = ""
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                self.navigationController?.navigationBar.isHidden = false
            }
            
            if let error = error {
                self.showAlert(title: "Login error", error.localizedDescription)
            }
        })
        
    }
    
    func registerButtonWasPressed() {
        guard let credentials = signInCredentials() else { return }
        FIRAuth.auth()?.createUser(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
            if error == nil {
                self.signedInUser = user
                self.setUpDatabaseReference()
                self.registerButton.isEnabled = false
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.checkTime), userInfo: nil, repeats: true)
                self.timer.fire()
                
                UIView.animate(withDuration: 1) {
                    var scaleAndFloat = CGAffineTransform.identity
                    scaleAndFloat = scaleAndFloat.scaledBy(x: 1.5, y: 1.5)
                    scaleAndFloat = scaleAndFloat.translatedBy(x: 0, y: -20)
                    self.registerButton.transform = scaleAndFloat
                    self.registerButton.alpha = 0
                    self.loginButton.isHidden = false
                    self.loginButton.isEnabled = true
                }
                self.fillInSingleton((user?.uid)!)
//                self.present(UINavigationController(rootViewController: HomeViewController()), animated: false)
            }
            if let error = error {
                self.showAlert(title: "Registering Error", error.localizedDescription)
                self.registerButton.isEnabled = true
                self.registerButton.transform = .identity
                self.loginButton.isHidden = true
                self.loginButton.isEnabled = false
            }
        })
    }
    
    func checkTime () {
        if self.time >= 1.0  {
            self.present(UINavigationController(rootViewController: HomeViewController()), animated: false)
            timer.invalidate()
        }
        
        self.time += 0.1
    }
    
    func registerTabWasPressed() {
        registerTab.isSelected = true
        loginTab.isSelected = false
        colorTab(button1: registerTab, button2: loginTab)
        
        registerButton.isEnabled = true
        registerTabLabel.textColor = UIColor.weLearnBlue
        loginTabLabel.textColor = UIColor.weLearnBlue.withAlphaComponent(0.6)
        toggleIsHiddenWhenTabIsChanged.map { $0.isHidden = false }
        
        
    }
    
    func loginTabWasPressed() {
        loginTab.isSelected = true
        registerTab.isSelected = false
        colorTab(button1: loginTab, button2: registerTab)
        
        loginButton.isEnabled =  true
        loginTabLabel.textColor = UIColor.weLearnBlue
        registerTabLabel.textColor = UIColor.weLearnBlue.withAlphaComponent(0.6)
        
        toggleIsHiddenWhenTabIsChanged.map { $0.isHidden = true }
    }
    
    // MARK: - Views created here
    
    lazy var logoPic: UIImageView = {
        let view = UIImageView()
        let originalImage = #imageLiteral(resourceName: "logoForSplash")
        let templateImage = originalImage.withRenderingMode(.alwaysTemplate)
        view.image = templateImage
        view.tintColor = UIColor.white
        view.layer.shadowColor = UIColor.weLearnBlack.cgColor
        view.layer.shadowOffset = CGSize(width: -5, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var logoOverlay: UIImageView = {
        let view = UIImageView()
        let originalImage = #imageLiteral(resourceName: "logoForSplash")
        let templateImage = originalImage.withRenderingMode(.alwaysTemplate)
        view.image = templateImage
        view.tintColor = UIColor(red:0.30, green:0.51, blue:0.69, alpha:1.0).withAlphaComponent(0.1)
        view.layer.masksToBounds = false
        return view
    }()
    
    //    lazy var logoHeader: UIOutlinedLabel = {
    //        let label = UIOutlinedLabel()
    //        label.text = "We \nLearn"
    //        label.font = UIFont(name: "Thirtysix", size: 72)
    //        label.numberOfLines = 0
    //        label.lineBreakMode = .byWordWrapping
    //        label.textColor = UIColor.white
    //        label.layer.shadowColor = UIColor.weLearnBlue.cgColor
    //        label.layer.shadowOffset = CGSize(width: -10, height: 10)
    //        label.layer.shadowOpacity = 1
    //        label.layer.shadowRadius = 1
    //        label.layer.masksToBounds = false
    //        return label
    //    }()
    
    lazy var loginTab: Box = {
        let button = Box()
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(loginTabWasPressed), for: .touchUpInside)
        button.isSelected = true
        return button
    }()
    
    lazy var registerTab: Box = {
        let button = Box()
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(registerTabWasPressed), for: .touchUpInside)
        button.isSelected = false
        return button
    }()
    
    lazy var loginTabLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20)
        label.textColor = UIColor.weLearnBlue
        label.text = "LOGIN"
        return label
    }()
    
    lazy var registerTabLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20)
        label.textColor = UIColor.weLearnBlue.withAlphaComponent(0.6)
        label.text = "REGISTER"
        return label
    }()
    
    lazy var box: Box = {
        let button = Box()
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var emailTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Email"
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.weLearnCoolWhite
        button.layer.borderColor = UIColor.weLearnBlue.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitle("Login".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 2
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.weLearnCoolWhite
        button.layer.borderColor = UIColor.weLearnBlue.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitle("register".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        button.addTarget(self, action: #selector(registerButtonWasPressed), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 2
        return button
    }()
    
    lazy var nameTextField: PaddedTextField = {
        let thirdTextfield = PaddedTextField()
        thirdTextfield.placeholder = "Preferred name"
        thirdTextfield.isSecureTextEntry = false
        thirdTextfield.spellCheckingType = .no
        thirdTextfield.autocorrectionType = .no
        thirdTextfield.autocapitalizationType = .none
        return thirdTextfield
    }()
    
    lazy var classTextField: PaddedTextField = {
        let fourthTextfield = PaddedTextField()
        fourthTextfield.placeholder = "Class"
        fourthTextfield.isSecureTextEntry = false
        fourthTextfield.spellCheckingType = .no
        fourthTextfield.autocorrectionType = .no
        fourthTextfield.autocapitalizationType = .none
        return fourthTextfield
    }()
    
    lazy var studentIDTextField: PaddedTextField = {
        let fifthTextfield = PaddedTextField()
        fifthTextfield.placeholder = "Student ID"
        fifthTextfield.isSecureTextEntry = true
        fifthTextfield.spellCheckingType = .no
        fifthTextfield.autocorrectionType = .no
        fifthTextfield.autocapitalizationType = .none
        return fifthTextfield
    }()
    
}
