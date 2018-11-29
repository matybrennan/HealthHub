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
    
    func getHeartRate(completionHandler: @escaping (AsyncCallResult<HeartRate>) -> Void) throws
    func configurePermissions()
    func getActivEenergy(completionHandler: @escaping (AsyncCallResult<ActiveEnergy>) -> Void) throws
    func runTest()
    func getWorkouts(completionHandler: @escaping (AsyncCallResult<Workout>) -> Void) throws
    func saveWorkout(completionHandler: @escaping (AsyncCallResult<Bool>) -> Void) throws
}

class ViewController: UIViewController {

    var interactor: ViewInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        interactor.configurePermissions()
        interactor.runTest()
        
        do {
            try interactor.saveWorkout(completionHandler: { (result) in
                switch result {
                case let .success(model):
                    print("Success: \(model)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription) for save workout")
                }
            })
        } catch {
            print("catch error: \(error.localizedDescription)")
        }
        
        do {
            try interactor.getWorkouts(completionHandler: { (result) in
                switch result {
                case let .success(model):
                    print("Success: \(model)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription) for workouts")
                }
            })
        } catch {
            print("catch error: \(error.localizedDescription)")
        }
        
        do {
            try interactor.getActivEenergy(completionHandler: { [unowned self] result in
                switch result {
                case let .success(model):
                    print("Success: \(model)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription) for active energy")
                }
            })
        } catch {
            print("catch error: \(error.localizedDescription)")
        }
        
        do {
            try interactor.getHeartRate { result in
                switch result {
                case let .success(vm): break
                    //print("Success: \(vm)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription) for heart rate")
                }
            }
        } catch {
            print("catch error: \(error)")
        }
    }
}

