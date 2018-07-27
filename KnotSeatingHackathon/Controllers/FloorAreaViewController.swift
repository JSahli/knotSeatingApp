//
//  FloorAreaViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jen Sipila on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

protocol FloorAreaViewControllerDelegate: class {
    func floorAreaViewController(controller: FloorAreaViewController, didSuccessfullyRemoveGuest guest: Guest?, fromTable table: Table?)
}

class FloorAreaViewController: UIViewController {

    var weddingTables = [WeddingTableView]()
    var highlightedTables = Set<WeddingTableView>()

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.maximumZoomScale = 1.0
            scrollView.minimumZoomScale = 1.0
        }
    }

    @IBOutlet weak var canvasView: UIView! {
        didSet {
            canvasView.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    weak var delegate: FloorAreaViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = canvasView.bounds.size
    }

    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }

//    @objc func handleRotate(recognizer: UIRotationGestureRecognizer) {
//        if let view = recognizer.view as? WeddingTableView {
//            view.transform = view.transform.rotated(by: recognizer.rotation)
//            view.tableNumberLabel.transform = view.tableNumberLabel.transform.rotated(by: -recognizer.rotation)
//            view.numGuestsLabel.transform = view.numGuestsLabel.transform.rotated(by: -recognizer.rotation)
//            recognizer.rotation = 0
//        }
//    }

    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        if let weddingTable = recognizer.view as? WeddingTableView {
            let guests = weddingTable.table.guests
            let vc = WeddingTableGuestsViewController(nibName: "WeddingTableGuestsViewController", bundle: nil)
            let minimumSize = vc.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            let height = CGFloat(min(guests.count * 70, 200))
            vc.preferredContentSize = CGSize(width: minimumSize.width, height: height)
            vc.delegate = self
            vc.table = weddingTable.table
            vc.modalPresentationStyle = .popover
            vc.popoverPresentationController?.sourceView = weddingTable
            vc.popoverPresentationController?.sourceRect = view.convert(weddingTable.bounds, to: canvasView)
            vc.popoverPresentationController?.canOverlapSourceViewRect = false
            vc.guestList = guests
            present(vc, animated: true, completion: nil)
        }
    }
}

extension FloorAreaViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: String.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let point = session.location(in: canvasView)
        for weddingTable in weddingTables {
            if weddingTable.frame.contains(point) {
                UIView.animate(withDuration: 0.3) {
                    weddingTable.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                    self.highlightedTables.insert(weddingTable)
                }
            }
        }
        for weddingTable in highlightedTables {
            if !weddingTable.frame.contains(point) {
                UIView.animate(withDuration: 0.3) {
                    weddingTable.transform = .identity
                    self.highlightedTables.remove(weddingTable)
                }
            }
        }
        return UIDropProposal(operation: .copy)
    }

    func deHighlightAllTables() {
        for weddingTable in highlightedTables {
            UIView.animate(withDuration: 0.3) {
                weddingTable.transform = .identity
                self.highlightedTables.remove(weddingTable)
            }
        }
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        deHighlightAllTables()
        if let draggedItems = session.localDragSession?.items {
            for draggedItem in draggedItems {
                if let tableType = draggedItem.localObject as? Table.TableType {
                    let point = session.location(in: canvasView)
                    let frame = CGRect(origin: CGPoint.zero, size: tableType.assetImage.size)
                    let newTable = Table(number: weddingTables.count + 1, tableType: tableType)
                    let weddingTable = WeddingTableView(table: newTable, frame: frame)

//                    let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(recognizer:)))
                    //Pan Gesture
                    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
                    weddingTable.addGestureRecognizer(pan)
//                    weddingTable.addGestureRecognizer(rotate)
                    weddingTable.cancelDelegate = self
                    // Tap Gesture
                    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
                    weddingTable.addGestureRecognizer(tap)
                    weddingTable.center = point
                    weddingTables.append(weddingTable)
                    weddingTable.setNeedsUpdate()
                    canvasView.addSubview(weddingTable)

                } else if let guestCell = draggedItem.localObject as? GuestTableViewCell,
                          let guest = guestCell.guest {

                    let point = session.location(in: canvasView)
                    for weddingTable in weddingTables {
                        if weddingTable.frame.contains(point), guest.seatedAtTable == nil {
                            guest.seatedAtTable = weddingTable.table.number
                            guestCell.selectionStyle = UITableViewCellSelectionStyle.none
                            guestCell.updateUI()
                            weddingTable.addGuest(guest)
                            }
                        }
                }
            }
        }
    }
}

extension FloorAreaViewController: CancelButtonDelegate {
    func cancelButtonPressed(selector: UIButton, selected table: WeddingTableView) {
        guard let index = weddingTables.index(of: table) else { return }
        weddingTables.remove(at: index)
        table.removeFromSuperview()
    }
}
extension FloorAreaViewController: WeddingTableGuestsViewControllerDelegate {
    func weddingTableGuestsViewController(controller: WeddingTableGuestsViewController, didDeleteGuest guest: Guest?, fromTable table: Table?) {
        if let table = table, let guest = guest {
            let success = table.removeGuest(guest: guest)
            if success {
                let subViews = canvasView.subviews
                    for subview in subViews {
                        if let sbv = subview as? WeddingTableView {
                            sbv.setNeedsUpdate()
                        }

                    }

                delegate?.floorAreaViewController(controller: self, didSuccessfullyRemoveGuest: guest, fromTable: table)
            }
        }
    }
}

