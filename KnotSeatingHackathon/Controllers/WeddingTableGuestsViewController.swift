//
//  WeddingTableGuestsViewController.swift
//  KnotSeatingHackathon
//
//  Created by Hamidreza Tavakoli on 7/27/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class WeddingTableGuestsViewController: UIViewController {

    var guestList: [Guest]? { didSet { tableView?.reloadData() } }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "WeddingTablePopoverTableViewCell", bundle: nil), forCellReuseIdentifier: "guestPopUpCell")
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension WeddingTableGuestsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestPopUpCell", for: indexPath)
        if let guest = guestList?[indexPath.row] {
            cell.textLabel?.text = guest.fullName
        }
        return cell
    }
}
