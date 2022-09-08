//
//  AppDelegate.swift
//  MBHealthTracker
//
//  Created by matybrennan on 02/05/2018.
//  Copyright (c) 2018 matybrennan. All rights reserved.
//

import UIKit
import MBHealthTracker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = ViewController()
        let interactor = ViewInteractor()
        controller.interactor = interactor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

