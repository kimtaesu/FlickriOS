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
    
    let commentTableView = UITableView()
    let dataSource = RxTableViewSectionedAnimatedDataSource<CommentSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: CommentCell.swiftIdentifier, for: ip) as? CommentCell else {
                return UITableViewCell()
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
        commentTableView.do {
            $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.swiftIdentifier)
            view.addSubview($0)
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
            .bind(to: commentTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
