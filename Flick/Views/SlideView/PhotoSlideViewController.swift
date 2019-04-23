import Foundation
import ReactorKit
import UIKit

class PhotoSlideViewController: UIViewController {

    let uiStackView = UIStackView()
    let leftPagingView = UIButton()
    let rightPagingView = UIButton()
    let photoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PhotoGeoCell.self, forCellWithReuseIdentifier: PhotoGeoCell.swiftIdentifier)
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    init(_ reactor: PhotoSlideReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.do {
            $0.backgroundColor = UIColor.blue
            $0.blurView.setup(style: .light, alpha: 0.5).enable()
        }
        uiStackView.do {
            view.addSubview($0)
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        leftPagingView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            uiStackView.addArrangedSubview($0)
            $0.isEnabled = false
            $0.setImage(Asset.icLeftPaging.image.maskWithColor(color: ColorName.pagingButtonNoraml), for: .normal)
            $0.setImage(Asset.icLeftPaging.image.maskWithColor(color: ColorName.pagingButtonDisable), for: .disabled)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.snp.makeConstraints({ make in
                make.width.equalTo(30)
            })
        }
        photoCollectionView.do {
            uiStackView.addArrangedSubview($0)
        }
        rightPagingView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            uiStackView.addArrangedSubview($0)
            $0.isEnabled = false
            $0.setImage(Asset.icLeftPaging.image.maskWithColor(color: ColorName.pagingButtonNoraml).rotate(radians: .pi), for: .normal)
            $0.setImage(Asset.icLeftPaging.image.maskWithColor(color: ColorName.pagingButtonDisable).rotate(radians: .pi), for: .disabled)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.snp.makeConstraints({ make in
                make.width.equalTo(30)
            })
        }
    }
}

extension PhotoSlideViewController: View, HasDisposeBag {
    func bind(reactor: PhotoSlideReactor) {

    }
}
