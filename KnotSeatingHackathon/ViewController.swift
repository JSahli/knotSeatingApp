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
    let catalogueViewController = CatalogueViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGuestsViewController()
        addCatalogueViewController()
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

    private func addCatalogueViewController() {
        addChildViewController(catalogueViewController)
        view.addSubview(catalogueViewController.view)
        catalogueViewController.didMove(toParentViewController: self)
        catalogueViewController.view.translatesAutoresizingMaskIntoConstraints = false
        catalogueViewController.view.topAnchor.constraint(equalTo: self.catalogueContainerView.topAnchor).isActive = true
        catalogueViewController.view.bottomAnchor.constraint(equalTo: self.catalogueContainerView.bottomAnchor).isActive = true
        catalogueViewController.view.trailingAnchor.constraint(equalTo: self.catalogueContainerView.trailingAnchor).isActive = true
        catalogueViewController.view.leadingAnchor.constraint(equalTo: self.catalogueContainerView.leadingAnchor).isActive = true
    }
}



