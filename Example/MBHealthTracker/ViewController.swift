//
//  ViewController.swift
//  MBHealthTracker
//
//  Created by matybrennan on 02/05/2018.
//  Copyright (c) 2018 matybrennan. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    var interactor: ViewInteractorProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.configurePermissions()
        interactor.runTest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

