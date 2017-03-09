//
//  AppDelegate.swift
//  weLearn
//
//  Created by Victor Zhong on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var cloudView: UIImageView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Firebase config
        FIRApp.configure()
        
        //UIApplication.shared.statusBarStyle = .lightContent
        StyleManager.styler.prettify()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = InitialViewController()
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor =  UIColor.white
        
        if let window = self.window {
            self.cloudView = UIImageView()
            
            self.cloudView?.contentMode = .center
            self.cloudView?.backgroundColor = UIColor.weLearnCoolAccent
            self.cloudView?.image = #imageLiteral(resourceName: "logoForSplash")
            self.cloudView?.alpha = 1
            let plainPic = #imageLiteral(resourceName: "logoForSplash")
            let tintedPic = plainPic.withRenderingMode(.alwaysTemplate)
            
            self.cloudView?.image = tintedPic
            self.cloudView?.tintColor = UIColor.white
            
            self.window?.addSubview(self.cloudView!)
            
            self.cloudView?.snp.makeConstraints { view in
                view.center.equalToSuperview()
                view.width.equalToSuperview()
                view.height.equalToSuperview()
            }
            
            UIView.animate(withDuration: 4.0) {
                self.cloudView?.alpha = 0
                // self.gradientView?.alpha = 0
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        let studentInfoUserDefaults = UserDefaults.standard
        guard let studentInfo = studentInfoUserDefaults.object(forKey: "studentInfo") as? [String : String],
            let studentClass = studentInfo["class"],
            let studentName = studentInfo["studentName"] else { return }
        
        
        let userDefaults = UserDefaults(suiteName: "group.com.welearn.app")
        
        if let urlDefaults = userDefaults?.object(forKey: "urlDefaults") as? [[String : String]] {
            for urlDict in urlDefaults {
                let databaseReference = FIRDatabase.database().reference().child("Links").child(studentClass).childByAutoId()
                var urlInfo = urlDict
                urlInfo["studentName"] = studentName
                databaseReference.setValue(urlInfo)
            }
        }
//        userDefaults?.removeObject(forKey: "urlDefaults")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("did enter the function")
    }
    
}

