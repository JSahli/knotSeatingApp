//
//  WeddingTableView.swift
//  KnotSeatingHackathon
//
//  Created by Kadell Gregory on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

protocol CancelButtonDelegate: class {
    func cancelButtonPressed(selector: UIButton, selected weddingTable: WeddingTableView)
}

import UIKit
//
//protocol WeddingTableViewDelegate: class {
//    func weddingTableView(view: WeddingTableView, shouldPerformDropInteraction interaction: UIDropInteraction, withSession session: UIDropSession)
//}

class WeddingTableView: UIView {

    @IBOutlet var contentView: UIView! { didSet { updateUI() } }
    @IBOutlet weak var tableNumberLabel: UILabel! { didSet { updateUI() } }
    @IBOutlet weak var backgroundImageView: UIImageView! { didSet { updateUI() } }
    @IBOutlet weak var numGuestsLabel: UILabel! { didSet { updateUI() } }

    var table: Table! { didSet { updateUI() } }


    weak var cancelDelegate: CancelButtonDelegate?

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

    func addGuest(_ guest: Guest) {
        table.addGuest(guest: guest)
        updateUI()
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
        guard let table = self.table else { return }
        backgroundImageView?.image = table.assetImage
        tableNumberLabel?.text = String(table.number)
        numGuestsLabel.text = String("\(table.guests.count)/ \(table.maxLimit)")
    }


    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        cancelDelegate?.cancelButtonPressed(selector: sender, selected: self)
    }
}



