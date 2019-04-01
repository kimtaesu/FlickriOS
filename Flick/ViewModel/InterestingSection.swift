import Foundation
import IGListKit

final class InterestingSection: NSObject {
    var header: String
    var items: [Thumbnailable] = []

    public init(header: String, items: [Thumbnailable] = []) {
        self.header = header
        self.items = items
    }
}

extension InterestingSection: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return header as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

final class InterestingSectionController: ListSectionController {
    
    private var object: InterestingSection?
    
    private weak var delegate: ListSectionDelegate?
    
    func setDelegate(_ delegate: ListSectionDelegate) {
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RecentThumbnailCell.self, for: self, at: index) as? RecentThumbnailCell,
            let item = self.object?.items[index] as? Photo else {
                return UICollectionViewCell()
        }
        cell.do {
            $0.configCell(item)
            $0.thumbnailView.hero.id = "image_\(index)"
            $0.thumbnailView.hero.modifiers = [.scale(0.8)]
            $0.thumbnailView.isOpaque = true
        }
        return cell
    }
    
    override func numberOfItems() -> Int {
        return object?.items.count ?? 0
    }
    override func didUpdate(to object: Any) {
        self.object = object as? InterestingSection
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.didSelectItem(at: index, item: object?.items[index], cell: self.cellForItem(at: index))
    }
}
