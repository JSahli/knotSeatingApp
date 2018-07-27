//
//  GuestsViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var collectionView: UICollectionView!
    let testGuests = Guest.dummyGuests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(GuestTableViewCell.nib, forCellReuseIdentifier: GuestTableViewCell.reuseId)
        tableView.rowHeight = 60
        tableView.dragInteractionEnabled = true
        tableView.dataSource = self
        tableView.dragDelegate = self
    }
}

extension GuestsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return testGuests.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testGuests[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return testGuests[section][0].group
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.reuseId) as? GuestTableViewCell else { return UITableViewCell() }
        let currentGuest = testGuests[indexPath.section][indexPath.row]
        cell.guest = currentGuest
        return cell
    }
}

extension GuestsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testGuests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuestCollectionViewCell.reuseId, for: indexPath) as? GuestCollectionViewCell else { return UICollectionViewCell() }
        let currentGuest = testGuests[indexPath.section][indexPath.row]
        cell.nameLabel.text = currentGuest.fullName
        cell.groupNameLabel.text = currentGuest.group
        return cell
    }
}

extension GuestsViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if let cell = tableView.cellForRow(at: indexPath) as? GuestTableViewCell {
            if cell.guest?.seatedAtTable != nil {
                return [UIDragItem]()
            }
        }
        session.localContext = tableView
        return dragItems(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        session.localContext = tableView
        return dragItems(at: indexPath)
    }
    
}

// MARK: Helper Functions
extension GuestsViewController {
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        guard let guestCell = tableView.cellForRow(at: indexPath) as? GuestTableViewCell else {
            return [UIDragItem]()
        }
        let name = testGuests[indexPath.section][indexPath.row].fullName
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: name as NSItemProviderWriting))
        dragItem.localObject = guestCell
        return [dragItem]
    }
}


