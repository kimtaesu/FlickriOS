//
//  CategoryViewController2.swift
//  Flick
//
//  Created by tskim on 03/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import PinterestLayout
import ReactorKit
import UIKit

public struct PinterestItem {
    public var image: UIImage
    public var text: String

    public init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
}

class CategoryViewController2: UIViewController {

    lazy var collectionView: UICollectionView = {
        let pinterestLayout = PinterestLayout()
        pinterestLayout.delegate = self
        pinterestLayout.cellPadding = 5
        pinterestLayout.numberOfColumns = 2
        return UICollectionView(frame: .zero, collectionViewLayout: pinterestLayout)
    }()

    private var _items: [Photo]?
    open var items: [Photo] {
        get {
            return _items ?? [Photo]()
        }
        set {
            _items = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = collectionView
        setupCollectionViewInsets()
        setupLayout()
        collectionView.dataSource = self
        collectionView.register(
            PinterestCell.self, forCellWithReuseIdentifier: "PinterestLayout.PinterestCell")
    }

    private func setupCollectionViewInsets() {
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 5,
            right: 5
        )
    }

    private func setupLayout() {

    }
}

extension CategoryViewController2: View, HasDisposeBag {
    func bind(reactor: CategoryReactor) {
        reactor.action.onNext(.fetchRecent)
        reactor.action.onNext(.fetchInteresting)

        reactor.state.map { $0.photos }
            .asDriver(onErrorJustReturn: [])
            .filterNil()
            .drive(onNext: { photos in
                self.items = photos
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController2: PinterestLayoutDelegate, UICollectionViewDataSource {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(
        collectionView: UICollectionView,
        heightForImageAtIndexPath indexPath: IndexPath,
        withWidth: CGFloat) -> CGFloat {
        let height = items[indexPath.item].findResolutionByWidth(width: Int(withWidth))?.height ?? 0
        return CGFloat(height)
    }

    public func collectionView(
        collectionView: UICollectionView,
        heightForAnnotationAtIndexPath indexPath: IndexPath,
        withWidth: CGFloat) -> CGFloat {
        return 0
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PinterestLayout.PinterestCell",
            for: indexPath) as? PinterestCell else {
            return UICollectionViewCell()
        }

        let item = items[indexPath.item]

        let url = URL(string: item.findResolutionByWidth(width: 400)?.imageUrl ?? "")
        cell.imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [],
            progressBlock: { receivedSize, totalSize in
            },
            completionHandler: { result in
            }
        )
        return cell
    }
}
