//
//  GuestTableViewCell.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/27/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var seatedAtView: UIView!
    @IBOutlet weak var seatedAtTableLabel: UILabel!

    var guest: Guest? {
        didSet { updateUI() }
    }

    static var reuseId: String {
        return "GuestTableViewCell"
    }

    static var nib: UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        seatedAtView.layer.cornerRadius = seatedAtView.frame.height/2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        seatedAtView.isHidden = true
        nameLabel.text = nil
        groupNameLabel.text = nil
        seatedAtTableLabel.text = nil
    }

    func updateUI() {
        guard let weddingGuest = guest else { return }
        nameLabel.text = weddingGuest.fullName
        groupNameLabel.text = weddingGuest.group
        if let tableNumber = weddingGuest.seatedAtTable {
            seatedAtView.isHidden = false
            seatedAtTableLabel.text = "\(tableNumber)"
        } else {
            seatedAtView.isHidden = true
        }
    }
}
