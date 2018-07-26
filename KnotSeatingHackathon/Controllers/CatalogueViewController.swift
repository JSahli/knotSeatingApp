import UIKit

class CatalogueViewController: UIViewController {

    var assets: [Table] = [Table]()

    weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.scrollDirection = .horizontal
            collectionView.register(UINib(nibName: "CatalogueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "catalogueCell")
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...3 {
            if let image = UIImage(named: "test") {
                let table = Table(number: i, assetImage: image, maxLimit: 10, guests: nil)
                assets.append(table)
            }
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
        return assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogueCell", for: indexPath) as? CatalogueCollectionViewCell {
            let table = assets[indexPath.row]
            cell.table = table
            return cell

        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 4, height: view.bounds.height)
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
                if let sourceIndexPath = item.sourceIndexPath, let table = item.dragItem.localObject as? Table {
                    collectionView.performBatchUpdates({
                        self.assets.remove(at: sourceIndexPath.row)
                        self.assets.insert(table, at: destinationIndexPath.row)
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
            dragItem.localObject = assets[indexPath.row]
            return [dragItem]
        } else {
            return []
        }
    }
}
