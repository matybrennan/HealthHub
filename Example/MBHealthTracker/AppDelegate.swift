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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let controller = ViewController()
        let tracker = MBHealthTracker()
        let interactor = ViewInteractor(healthTracker: tracker)
        controller.interactor = interactor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        let nService = NutritionService()
        do {
            try nService.getNutrition(fromType: .energyConsumed, completionHandler: { res in
                switch res {
                case let .failed(error): print("res error: \(error)")
                case let .success(vm): print("res success: \(vm)")
                }
            })
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        
        
        return true
    }
    
}

