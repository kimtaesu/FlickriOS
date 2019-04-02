//
//  DetailViewController.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxKingfisher
import UIKit

class PhotoDetailViewController: UIViewController {

    let originalImageView = UIImageView()
    let descView = UILabel()
    let profileImageView = UIImageView()
    let viewsCountingView = UIView()
//    private let commentsTableView = UITableView()
//    private let tagsCollectionView = UICollectionView()
    let geoView = UIButton()
    let licentCountView = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initViews()
        initNavigationItem()
    }
    private func initViews() {
        let preferSize = CGSize(width: view.frame.width, height: view.frame.height * 0.4)

        reactor?.action.onNext(.loadComment)
        originalImageView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(safeAreaTop)
                make.height.equalTo(view.frame.height * 0.4)
            })
        }
        descView.do {
            view.addSubview($0)
            $0.textColor = UIColor.black
            $0.snp.makeConstraints({ make in
                make.center.equalToSuperview()
            })
        }
    }
    private func initNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.icClose.image, style: .plain, target: self, action: #selector(close))
    }

    @objc
    func close() {
        hero.dismissViewController()
    }
}

extension PhotoDetailViewController: View, HasDisposeBag {
    func bind(reactor: PhotoDetailReactor) {
        reactor.state.map { $0.title }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        reactor.state.map { $0.desc }
            .bind(to: descView.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.detailImage }
            .bind(to: originalImageView.kf.rx.image(options: [.transition(.fade(0.2))]))
            .disposed(by: disposeBag)
    }
}

extension PhotoDetailViewController {
    convenience init(_ photo: Photo) {
        self.init(nibName: nil, bundle: nil)
        reactor = PhotoDetailReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!, photo: photo)
    }
}
