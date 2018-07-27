//
//  WeddingTableGuestsViewController.swift
//  KnotSeatingHackathon
//
//  Created by Hamidreza Tavakoli on 7/27/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

protocol WeddingTableGuestsViewControllerDelegate: class {
    func weddingTableGuestsViewController(controller: WeddingTableGuestsViewController, didDeleteGuest guest: Guest?, fromTable table: Table?)
}

class WeddingTableGuestsViewController: UIViewController {

    var guestList: [Guest]? { didSet { tableView?.reloadData() } }
    var table: Table?

    weak var delegate: WeddingTableGuestsViewControllerDelegate?
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "guestPopUpCell", for: indexPath) as? WeddingTablePopoverTableViewCell {
            if let guest = guestList?[indexPath.row] {
                cell.guest = guest
                cell.delegate = self
            }
            return cell
        }

        return UITableViewCell()
    }
}

extension WeddingTableGuestsViewController: WeddingTablePopoverTableViewCellDelegate {
    func weddingTablePopoverCell(cell: WeddingTablePopoverTableViewCell, didTapDeleteButtonForGuest: Guest?) {
        if let indexPath = tableView.indexPath(for: cell) {
            let guest = guestList?[indexPath.row]
            tableView.performBatchUpdates({
                guestList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }) { _ in
                self.delegate?.weddingTableGuestsViewController(controller: self, didDeleteGuest: guest, fromTable: self.table)
            }

        }
    }
}
