//
//  AppDelegate.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let locationManager = CLLocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
     
        if #available(iOS 13.0,*){
                     return true
               }else{
                   window = UIWindow(frame: UIScreen.main.bounds)
                   window?.rootViewController = rootViewCtrl()
                   window?.makeKeyAndVisible()
                     return true
               }
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    func rootViewCtrl() -> UIViewController {
            print("rootView  init")
        let mainViewController = ViewControllerRoot.get()
            mainViewController.view.backgroundColor = UIColor.lightGray
            let rootViewController = UINavigationController(rootViewController: mainViewController)
            print("rootView  returned ")
            return rootViewController
        }
}

