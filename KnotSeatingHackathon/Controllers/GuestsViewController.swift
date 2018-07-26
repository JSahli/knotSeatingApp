//
//  GuestsViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let testGuests = Guest.dummyGuests()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(GuestCollectionViewCell.nib, forCellWithReuseIdentifier: GuestCollectionViewCell.reuseId)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 50)
        collectionView.dragDelegate = self
        collectionView.dragInteractionEnabled = true
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
        let currentGuest = testGuests[indexPath.row]
        cell.nameLabel.text = currentGuest.fullName
        cell.groupNameLabel.text = currentGuest.group
        return cell
    }
}

extension GuestsViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
}

// MARK: Helper Functions
extension GuestsViewController {
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let image = (collectionView.cellForItem(at: indexPath) as? GuestCollectionViewCell)?.nameLabel.text{
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image as NSItemProviderWriting))
            dragItem.localObject = testGuests[indexPath.row]
            return [dragItem]
        } else {
            return []
        }
    }
}


