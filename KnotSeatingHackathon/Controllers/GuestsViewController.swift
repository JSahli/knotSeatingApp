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
//        configureCollectionView()
        configureTableView()
    }

    private func configureTableView() {
        tableView.dragInteractionEnabled = true
        tableView.dataSource = self
        tableView.dragDelegate = self
    }

//    private func configureCollectionView() {
//        collectionView.dataSource = self
//        collectionView.register(GuestCollectionViewCell.nib, forCellWithReuseIdentifier: GuestCollectionViewCell.reuseId)
//        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//        layout.itemSize = CGSize(width: collectionView.frame.width, height: 50)
//        collectionView.dragDelegate = self
//        collectionView.dragInteractionEnabled = true
//    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let currentGuest = testGuests[indexPath.section][indexPath.row]
        cell.textLabel?.text = currentGuest.fullName
        cell.detailTextLabel?.text = currentGuest.group
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

//extension GuestsViewController: UICollectionViewDragDelegate {
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        session.localContext = collectionView
//        return dragItems(at: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
//        return dragItems(at: indexPath)
//    }
//}

extension GuestsViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
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
        if let name = (tableView.cellForRow(at: indexPath))?.textLabel?.text{
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: name as NSItemProviderWriting))
            dragItem.localObject = testGuests[indexPath.section][indexPath.row]
            return [dragItem]
        } else {
            return []
        }
    }
}


