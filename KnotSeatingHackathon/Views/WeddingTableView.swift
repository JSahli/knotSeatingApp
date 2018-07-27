//
//  WeddingTableView.swift
//  KnotSeatingHackathon
//
//  Created by Kadell Gregory on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

protocol WeddingTableViewDelegate: class {
    func weddingTableView(view: WeddingTableView, shouldPerformDropInteraction interaction: UIDropInteraction, withSession session: UIDropSession)
}

class WeddingTableView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var numGuestsLabel: UILabel!

    var table: Table! { didSet { updateUI() } }

    weak var delegate: WeddingTableViewDelegate?

    init(table: Table, frame: CGRect) {
        super.init(frame: frame)
        prepare()
        self.table = table
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }

    func setNeedsUpdate() {
        updateUI()
    }

    private func prepare() {
        Bundle.main.loadNibNamed("WeddingTableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

    private func updateUI() {
        guard let table = self.table, let number = table.number else { return }
        backgroundImageView?.image = table.assetImage
        tableNumberLabel?.text = String(number)
        numGuestsLabel.text = String("0/ \(table.maxLimit)")
    }
}



