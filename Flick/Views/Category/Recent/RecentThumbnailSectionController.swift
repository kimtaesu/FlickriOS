import Foundation
import IGListKit

final class RecentThumbnailSectionController: ListSectionController {

    private var object: RecentItem?

    private weak var delegate: ListSectionDelegate?

    func setDelegate(_ delegate: ListSectionDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 55)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RecentThumbnailCell.self, for: self, at: index) as? RecentThumbnailCell,
            let item = self.object?.items[index] else {
                return UICollectionViewCell()
        }
        cell.configCell(item)
        return cell
    }

    override func numberOfItems() -> Int {
        return object?.items.count ?? 0
    }
    override func didUpdate(to object: Any) {
        self.object = object as? RecentItem
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.didSelectItem(at: index, item: object?.items[index])
    }
}
