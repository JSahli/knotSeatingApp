//
//  WeddingTablePopoverTableViewCell.swift
//  KnotSeatingHackathon
//
//  Created by Hamidreza Tavakoli on 7/27/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

protocol WeddingTablePopoverTableViewCellDelegate: class {
    func weddingTablePopoverCell(cell: WeddingTablePopoverTableViewCell, didTapDeleteButtonForGuest: Guest?)
}

class WeddingTablePopoverTableViewCell: UITableViewCell {

    var guest: Guest? { didSet { updateUI() } }
    weak var delegate: WeddingTablePopoverTableViewCellDelegate?

    @IBOutlet weak var nameLabel: UILabel! { didSet { updateUI() } }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func removeGuestFromTable(_ sender: Any) {
        delegate?.weddingTablePopoverCell(cell: self, didTapDeleteButtonForGuest: guest)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func updateUI() {
        guard let guest = guest else { return }
        nameLabel?.text = guest.fullName
    }
}
