//
//  ViewController.swift
//  MBHealthTracker
//
//  Created by matybrennan on 02/05/2018.
//  Copyright (c) 2018 matybrennan. All rights reserved.
//

import UIKit
import MBHealthTracker

protocol ViewInteractorProtocol {
    
    func getHeartRate(completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) throws
    func configurePermissions()
    func getActivEenergy(completionHandler: @escaping (MBAsyncCallResult<ActiveEnergy>) -> Void) throws
    func runTest()
    func getWorkouts(completionHandler: @escaping (MBAsyncCallResult<Workout>) -> Void) throws
    func saveWorkout(completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
    func saveSleep(completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
    func getSleep(completionHandler: @escaping (MBAsyncCallResult<Sleep>) -> Void) throws
}

class ViewController: UIViewController {

    var interactor: ViewInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        interactor.configurePermissions()
        //interactor.runTest()
        
        print("---------------------------------")
        
        do {
            try interactor.getSleep(completionHandler: { result in
                switch result {
                case let .success(model):
                    print("Success: \(model)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription) for sleep value")
                }
            })
        } catch {
            print("catch error: \(error.localizedDescription)")
        }
        
        
        print("---------------------------------")
    }
}

