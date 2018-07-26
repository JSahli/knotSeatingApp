//
//  GuestCollectionViewCell.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class GuestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!

    static var reuseId: String {
        return "GuestCollectionViewCell"
    }

    static var nib: UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
}
