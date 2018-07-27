//
//  FloorAreaViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jen Sipila on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit
class FloorAreaViewController: UIViewController {

    var weddingTables = [WeddingTableView]() {
        didSet {
            if !weddingTables.isEmpty, let lastTable = weddingTables.last {
                let nextNumber = weddingTables.count
                print(nextNumber)
                lastTable.table.set(tableNumber: nextNumber)
                lastTable.setNeedsUpdate()
            }
        }
    }
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = canvasView.bounds.size
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
                if let table = draggedItem.localObject as? Table {
                    let point = session.location(in: canvasView)
                    let frame = CGRect(origin: CGPoint.zero, size: table.assetImage.size)
                    let weddingTable = WeddingTableView(table: table, frame: frame)
                    weddingTable.center = point
                    weddingTables.append(weddingTable)
                    canvasView.addSubview(weddingTable)

                } else if let guest = draggedItem.localObject as? Guest {
                    let point = session.location(in: canvasView)
                    let label = UILabel(frame: CGRect(x: point.x, y: point.y, width: 80, height: 30))
                    
                    label.text = guest.fullName
                    canvasView.addSubview(label)
                    label.center = point
                }
            }
        }
    }
}


//extension Bundle {
//    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
//        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
//            return view
//        }
//
//        fatalError("Could not load view with type \(String(describing: type))")
//    }
//}
