//
//  CommentViewController.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import UIKit

class CommentViewController: UIViewController {

    let commentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.swiftIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<CommentSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: CommentCell.swiftIdentifier, for: ip) as? CommentCell else {
                return UICollectionViewCell()
            }
            cell.configCell(item)
            return cell
        }
    )

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ photoId: String) {
        super.init(nibName: nil, bundle: nil)
        reactor = CommentReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!, photoId: photoId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commentCollectionView.do {
            view.addSubview($0)
            $0.rx.setDelegate(self).disposed(by: disposeBag)
            $0.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(safeAreaTop)
                make.bottom.equalTo(safeAreaBottom)
            })
        }
    }
}

extension CommentViewController: View, HasDisposeBag {
    func bind(reactor: CommentReactor) {
        reactor.action.onNext(.setLoadComments)

        reactor.state.map { $0.commentSections }
            .filterNil()
            .bind(to: commentCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.swiftIdentifier, for: indexPath) as? CommentCell else { return CGSize.zero }
        return CGSize(width: view.frame.width, height: 100)
    }
}
