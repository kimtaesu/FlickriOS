import Foundation
import IGListKit

final class CategoryPhotoSection: NSObject {
    var header: String
    var items: [ViewModelProtocol] = []

    public init(header: String, items: [ViewModelProtocol] = []) {
        self.header = header
        self.items = items
    }
}

extension CategoryPhotoSection: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

extension CategoryPhotoSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionContext?.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                for: self,
                class: CategoryHeaderCell.self,
                at: index
            ) as? CategoryHeaderCell, let header = object?.header else { return UICollectionReusableView() }
            view.configCell(header)
            return view
        default:
            fatalError()
        }
        return UICollectionReusableView()
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 40)
    }
}
final class CategoryPhotoSectionController: ListSectionController {

    private var object: CategoryPhotoSection?

    private weak var delegate: ListSectionDelegate?

    override init() {
        super.init()
        supplementaryViewSource = self
    }

    func setDelegate(_ delegate: ListSectionDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 55)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if let cell = collectionContext?.dequeueReusableCell(of: CategoryThumbnailCell.self, for: self, at: index) as? CategoryThumbnailCell,
            let item = self.object?.items[index] as? Photo {
            cell.do {
                $0.configCell(item)
                $0.thumbnailView.hero.id = "image_\(index)"
                $0.thumbnailView.hero.modifiers = [.scale(0.8)]
                $0.thumbnailView.isOpaque = true
            }
            return cell
        } else if let cell = collectionContext?.dequeueReusableCell(of: LoadingThumbnailCell.self, for: self, at: index) as? LoadingThumbnailCell {
            return cell
        } else if let cell = collectionContext?.dequeueReusableCell(of: PhotoRetryCell.self, for: self, at: index) as? PhotoRetryCell {
            return cell
        } else {
            fatalError()
        }
    }

    override func numberOfItems() -> Int {
        return object?.items.count ?? 0
    }
    override func didUpdate(to object: Any) {
        self.object = object as? CategoryPhotoSection
    }

    override func didSelectItem(at index: Int) {
        self.delegate?.didSelectItem(at: index, item: object?.items[index], cell: self.cellForItem(at: index))
    }
}
