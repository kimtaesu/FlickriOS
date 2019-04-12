//
//  CommentCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class CommentCell: UICollectionViewCell, SwiftNameIdentifier {
    let content = UILabel()
    let authorName = UILabel()
    let datecreate = UILabel()
    let profile = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    private func initViews() {
//        profile.do {
//            let width = 36
//            contentView.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.width.equalTo(width)
//                make.height.equalTo(width)
//                make.leading.equalToSuperview()
//                make.top.equalToSuperview()
//            })
//            $0.layer.cornerRadius = CGFloat(width / 2)
//            $0.clipsToBounds = true
//        }
//        authorName.do {
//            contentView.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.leading.equalTo(profile.snp.trailing)
//                make.top.equalTo(profile.snp.top)
//            })
//        }
//        datecreate.do {
//            contentView.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.leading.equalTo(authorName.snp.trailing)
//                make.top.equalToSuperview()
//            })
//        }
        content.do {
            $0.numberOfLines = 0
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
//                make.top.equalTo(authorName.snp.bottom)
//                make.leading.equalTo(authorName.snp.leading)
//                make.trailing.equalToSuperview()
//                make.height.equalTo(100)
            })
        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        content.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        let height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        layoutAttributes.bounds.size.height = height
        return layoutAttributes
    }
}

extension CommentCell {
    func configCell(_ comment: Comment) {
//        profile.kf.setImage(
//            with: URL(string: comment.iconBuddy),
//            placeholder: nil,
//            options: [],
//            progressBlock: { receivedSize, totalSize in },
//            completionHandler: { result in }
//        )
        
        if let commentData = comment.content.data(using: String.Encoding.unicode, allowLossyConversion: true),
            let attrString = try? NSAttributedString(data: commentData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            content.attributedText = attrString
        } else {
        }
//            content.text = comment.content
//        authorName.text = comment.authorName
//        datecreate.text = comment.datecreate
    }
}
