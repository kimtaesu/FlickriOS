////
////  CategoryViewController2.swift
////  Flick
////
////  Created by tskim on 03/04/2019.
////  Copyright © 2019 hucet. All rights reserved.
////
//
//import ReactorKit
//import UIKit
//
//class CategoryViewController2: UIViewController {
//
//    lazy var collectionView: UICollectionView = {
//        let pinterestLayout = PinterestLayout()
//        pinterestLayout.delegate = self
//        pinterestLayout.cellPadding = 5
//        pinterestLayout.numberOfColumns = 2
//        return UICollectionView(frame: .zero, collectionViewLayout: pinterestLayout)
//    }()
//
//    private var items: [Photo] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view = collectionView
//        collectionView.do {
//            $0.delegate = self
//            $0.dataSource = self
//            $0.register(PinterestCell.self, forCellWithReuseIdentifier: PinterestCell.swiftIdentifier)
//            $0.backgroundColor = .clear
//            $0.contentInset = UIEdgeInsets(
//                top: 3,
//                left: 3,
//                bottom: 3,
//                right: 3
//            )
//        }
//    }
//}
//
//extension CategoryViewController2: View, HasDisposeBag {
//    func bind(reactor: CategoryReactor) {
//        reactor.action.onNext(.fetchGeoSearch)
//
//        reactor.state.map { $0.photos }
//            .asDriver(onErrorJustReturn: [])
//            .filterNil()
//            .drive(onNext: { [weak self] photos in
//                guard let self = self else { return }
//                self.items = photos
//                self.collectionView.reloadData()
//            })
//            .disposed(by: disposeBag)
//    }
//}
//
//extension CategoryViewController2: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = cell as? PinterestCell else {
//            return
//        }
//        cell.imageView.kf.cancelDownloadTask()
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = items[indexPath.row]
//        let photoVC = PhotoDetailViewController(photo).then {
//            $0.imageView.hero.isEnabled = true
//            $0.imageView.hero.id = L10n.heroImageId(indexPath.section, indexPath.row)
//        }
//        let vc = UINavigationController(rootViewController: photoVC).then {
//            $0.hero.isEnabled = true
//        }
//        self.present(vc, animated: true)
//    }
//}
//extension CategoryViewController2: UICollectionViewDataSource {
//    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: PinterestCell.swiftIdentifier,
//            for: indexPath) as? PinterestCell else {
//            return UICollectionViewCell()
//        }
//
//        let item = items[indexPath.item]
//
//        let url = URL(string: item.nearHeightByWidth(width: 400)?.imageUrl ?? "")
//        cell.imageView.do {
//
//            $0.hero.id = L10n.heroImageId(indexPath.section, indexPath.row)
//            $0.hero.modifiers = [.fade, .scale(0.8)]
//            $0.kf.setImage(
//                with: url,
//                placeholder: nil,
//                options: [],
//                progressBlock: { receivedSize, totalSize in
//                },
//                completionHandler: { result in
//                }
//            )
//        }
//        return cell
//    }
//}
//extension CategoryViewController2: PinterestLayoutDelegate {
//    convenience init() {
//        self.init(nibName: nil, bundle: nil)
//        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
//    }
//
//    public func collectionView(
//        collectionView: UICollectionView,
//        heightForImageAtIndexPath indexPath: IndexPath,
//        withWidth: CGFloat) -> CGFloat {
//        let height = items[indexPath.item].nearHeightByWidth(width: Int(withWidth))?.height ?? 0
//        return CGFloat(height)
//    }
//
//    public func collectionView(
//        collectionView: UICollectionView,
//        heightForAnnotationAtIndexPath indexPath: IndexPath,
//        withWidth: CGFloat) -> CGFloat {
//        return 0
//    }
//}
