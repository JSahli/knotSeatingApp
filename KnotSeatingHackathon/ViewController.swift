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
    let floorPlanViewController = FloorAreaViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGuestsViewController()
        addCatalogueViewController()
        addFloorViewController()
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

    private func addFloorViewController() {
        addChildViewController(floorPlanViewController)
        view.addSubview(floorPlanViewController.view)
        floorPlanViewController.delegate = self
        floorPlanViewController.didMove(toParentViewController: self)
        floorPlanViewController.view.translatesAutoresizingMaskIntoConstraints = false
        floorPlanViewController.view.topAnchor.constraint(equalTo: self.floorPlanContainerView.topAnchor).isActive = true
        floorPlanViewController.view.bottomAnchor.constraint(equalTo: self.floorPlanContainerView.bottomAnchor).isActive = true
        floorPlanViewController.view.trailingAnchor.constraint(equalTo: self.floorPlanContainerView.trailingAnchor).isActive = true
        floorPlanViewController.view.leadingAnchor.constraint(equalTo: self.floorPlanContainerView.leadingAnchor).isActive = true
    }
}

extension ViewController: FloorAreaViewControllerDelegate {
    func floorAreaViewController(controller: FloorAreaViewController, didSuccessfullyRemoveGuest guest: Guest?, fromTable table: Table?) {
        // update the guest vc
        guestsViewController.setNeedsUpdate()
        
    }


}



