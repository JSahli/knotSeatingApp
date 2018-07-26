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
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: String.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if let draggedItems = session.localDragSession?.items {
            for draggedItem in draggedItems {
                if let table = draggedItem.localObject as? Table {
                    let point = session.location(in: canvasView)
                    let imageView = UIImageView(image: table.assetImage)
                    canvasView.addSubview(imageView)
                    imageView.center = point

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
