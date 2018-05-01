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
    
    func getHeartRate(completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) throws
    func configurePermissions()
    
    func runTest()
}

class ViewController: UIViewController {

    var interactor: ViewInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        interactor.configurePermissions()
        interactor.runTest()
        
        do {
            try interactor.getHeartRate { result in
                switch result {
                case let .success(vm):
                    print("Success: \(vm)")
                case let .failed(error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("catch error: \(error)")
        }
    }
}

