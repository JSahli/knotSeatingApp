//
//  ViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var guestContainerView: UIView!
    @IBOutlet weak var catalogueContainerView: UIView!
    @IBOutlet weak var floorPlanContainerView: UIView!
    let guestsViewController = GuestsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGuestsViewController()
    }

    func addGuestsViewController() {
        addChildViewController(guestsViewController)
        view.addSubview(guestsViewController.view)
        guestsViewController.didMove(toParentViewController: self)
        guestsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        guestsViewController.view.topAnchor.constraint(equalTo: self.guestContainerView.topAnchor).isActive = true
        guestsViewController.view.bottomAnchor.constraint(equalTo: self.guestContainerView.bottomAnchor).isActive = true
        guestsViewController.view.trailingAnchor.constraint(equalTo: self.guestContainerView.trailingAnchor).isActive = true
        guestsViewController.view.leadingAnchor.constraint(equalTo: self.guestContainerView.leadingAnchor).isActive = true
    }
}



