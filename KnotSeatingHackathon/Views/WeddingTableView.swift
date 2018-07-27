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
    var table: Table! { didSet { updateUI() } }

    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

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
        addInteraction(UIDropInteraction(delegate: self))
        addInteraction(UIDragInteraction(delegate: self))
    }

    private func updateUI() {
        guard let table = self.table else { return }
        backgroundImageView?.image = table.assetImage
        tableNumberLabel?.text = String(table.number)
    }
}

extension WeddingTableView: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: NSString.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        if let superV = superview {
            let dropPoint = session.location(in: superV)
            if superV.bounds.contains(dropPoint) {
                return UIDropProposal(operation: UIDropOperation.move)
            }
        }
        return UIDropProposal(operation: UIDropOperation.cancel)

    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        delegate?.weddingTableView(view: self, shouldPerformDropInteraction: interaction, withSession: session)
    }

}

extension WeddingTableView: UIDragInteractionDelegate {

    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: table.assetImage))
        //session.localContext = self.superview
        dragItem.localObject = table
        return [dragItem]
    }

}


