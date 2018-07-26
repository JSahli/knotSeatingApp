//
//  CatalogCollectionViewCell.swift
//  KnotSeatingHackathon
//
//  Created by Hamidreza Tavakoli on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class CatalogueCollectionViewCell: UICollectionViewCell {

    var imageToShow: UIImage? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var assetImageView: UIImageView! { didSet { updateUI() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func updateUI() {
        assetImageView?.image = imageToShow
    }

}
