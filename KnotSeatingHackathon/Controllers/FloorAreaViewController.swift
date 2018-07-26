//
//  FloorAreaViewController.swift
//  KnotSeatingHackathon
//
//  Created by Jen Sipila on 7/26/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit
class FloorAreaViewController: UIViewController {

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
        return session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if let draggedItems = session.localDragSession?.items {
            for draggedItem in draggedItems {
                if let table = draggedItem.localObject as? Table {
                    let point = session.location(in: canvasView)
                    let frame = CGRect(origin: CGPoint.zero, size: table.assetImage.size) // the frame is wrong
                    let weddingTable = Bundle.loadView(fromNib: "WeddingTableView", withType: WeddingTableView.self)
                    weddingTable.frame = frame
                    canvasView.addSubview(weddingTable)
                    weddingTable.table = table
                    weddingTable.center = point

                } else if let guest = draggedItem.localObject as? Guest {

                }
            }
            
        }
    }
}


extension Bundle {
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type \(String(describing: type))")
    }
}
