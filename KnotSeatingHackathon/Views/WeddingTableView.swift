//
//  WeddingTableView.swift
//  KnotSeatingHackathon
//
//  Created by Kadell Gregory on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class WeddingTableView: UIView {


    var table: Table? { didSet { updateUI() } }

    @IBOutlet weak var tableNumberLabel: UILabel! { didSet { updateUI() } }
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFit
        updateUI()

        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("Nothing")
    }

    private func updateUI() {
        guard let table = self.table else { return }
        backgroundImageView?.image = table.assetImage
        tableNumberLabel?.text = String(table.number)
    }
}


