import UIKit

class CatalogViewController: UIViewController {

    var assets: [Table] = [Table]()

    weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        if collectionView == nil {
            let collectionView = UICollectionView(frame: view.bounds)
            view.addSubview(collectionView)
            self.collectionView = collectionView
        }
    }
}

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    
}
