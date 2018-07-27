//
//  CatalogCollectionViewCell.swift
//  KnotSeatingHackathon
//
//  Created by Hamidreza Tavakoli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class CatalogueCollectionViewCell: UICollectionViewCell {

    var table: Table? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var assetImageView: UIImageView! { didSet { updateUI() } }
    @IBOutlet weak var guestAllowedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func updateUI() {
        if let currentTable = table {
            assetImageView?.image = currentTable.assetImage
            guestAllowedLabel.text = "\(currentTable.tableType.rawValue) Guests"
        }
    }

}
