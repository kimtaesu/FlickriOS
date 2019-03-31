//
//  RecentCell.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

class RecentThumbnailCell: UICollectionViewCell, SwiftNameIdentifier {

    private let thumbnailView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    private func initViews() {
        thumbnailView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
}

extension RecentThumbnailCell {
    func configCell(_ thumbnail: Thumbnail) {
        thumbnailView.kf.setImage(
            with: URL(string: thumbnail.thumbnail.imageUrl),
            placeholder: nil,
            options: [.transition(.fade(1))],
            progressBlock: { receivedSize, totalSize in
                logger.info("progressBlock: \(thumbnail)")
            },
            completionHandler: { result in
                logger.info(result)
                logger.info("completionHandler: \(thumbnail): Finished")
            }
        )
    }
}
