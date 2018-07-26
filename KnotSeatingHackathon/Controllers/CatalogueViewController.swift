import UIKit

class CatalogueViewController: UIViewController {

    var assets: [Table] = [Table]()

    weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.dragDelegate = self
           // collectionView.dropDelegate = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            collectionView.register(UINib(nibName: "CatalogueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "catalogueCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...5 {
            if let image = UIImage(named: "test") {
                let table = Table(number: i, assetImage: image, maxLimit: 10)
                assets.append(table)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        if collectionView == nil {
            let collectionView = UICollectionView(frame: view.bounds)
            view.addSubview(collectionView)
            self.collectionView = collectionView
        }
    }
}

extension CatalogueViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "catalogueCell", for: indexPath)
    }
    
}

extension CatalogueViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }

}

//extension CatalogueViewController: UICollectionViewDropDelegate {
//
//}

// MARK: Helper Functions
extension CatalogueViewController {
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let image = (collectionView.cellForItem(at: indexPath) as? CatalogueCollectionViewCell)?.assetImageView.image {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
            dragItem.localObject = image
            return [dragItem]
        } else {
            return []
        }
    }
}
