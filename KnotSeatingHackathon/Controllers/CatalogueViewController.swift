import UIKit

class CatalogueViewController: UIViewController {

    var tableTypes = Table.TableType.allCases

    weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.scrollDirection = .horizontal
            collectionView.register(UINib(nibName: "CatalogueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "catalogueCell")
            collectionView.backgroundColor =  UIColor.darkGray
            //Rounding top left corner of catalogue
            let rectShape = CAShapeLayer()
            rectShape.bounds = collectionView.layer.frame
            rectShape.position = collectionView.center
            rectShape.path = UIBezierPath(roundedRect: collectionView.layer.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            collectionView.layer.mask = rectShape

            collectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        if collectionView == nil {
            let flowLayout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flowLayout)
            view.addSubview(collectionView)
            self.collectionView = collectionView
        }
    }
}

extension CatalogueViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogueCell", for: indexPath) as? CatalogueCollectionViewCell {
            let tableType = tableTypes[indexPath.row]
            cell.tableType = tableType
            
            return cell

        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tableType = tableTypes[indexPath.row]
        if tableType == .rectangle {
           return CGSize(width: 200.0, height: 100.0)
        }
        return CGSize(width: 100.0, height: 100.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (view.bounds.width / 5) - 40.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (view.bounds.width / 5) - 40.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
    }
    
}

extension CatalogueViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }

}

extension CatalogueViewController: UICollectionViewDropDelegate {

    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: UICollectionViewDropIntent.insertAtDestinationIndexPath)

    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if let destinationIndexPath = coordinator.destinationIndexPath {
            for item in coordinator.items {
                if let sourceIndexPath = item.sourceIndexPath, let table = item.dragItem.localObject as? Table.TableType {
                    collectionView.performBatchUpdates({
                        self.tableTypes.remove(at: sourceIndexPath.row)
                        self.tableTypes.insert(table, at: destinationIndexPath.row)
                        self.collectionView.deleteItems(at: [sourceIndexPath])
                        self.collectionView.insertItems(at: [destinationIndexPath])
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
        }
    }
}

// MARK: Helper Functions
extension CatalogueViewController {
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let image = (collectionView.cellForItem(at: indexPath) as? CatalogueCollectionViewCell)?.assetImageView.image {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
            dragItem.localObject = tableTypes[indexPath.row]
            return [dragItem]
        } else {
            return []
        }
    }
}
