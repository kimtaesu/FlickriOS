//
//  CommentCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import ReadMoreTextView

class CommentCell: UITableViewCell, SwiftNameIdentifier {
    let content = UITextView()
    let authorName = UILabel()
    let datecreate = UILabel()
    let permalink = UIImageView()
    let profile = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        profile.do {
            let width = 36
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.width.height.equalTo(width)
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
            })
            $0.layer.cornerRadius = CGFloat(width / 2)
            $0.clipsToBounds = true
        }
        authorName.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(profile.snp.trailing)
                make.top.equalTo(profile.snp.top)
            })
        }
        datecreate.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(authorName.snp.trailing)
                make.top.equalToSuperview()
            })
        }
        content.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(authorName.snp.bottom)
                make.leading.equalTo(authorName.snp.leading)
                make.trailing.equalToSuperview()
                make.height.equalTo(100)
            })
        }
        permalink.do {
            let width = 36
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(authorName.snp.leading)
                make.top.equalTo(content.snp.bottom)
                make.width.equalTo(width)
                make.height.equalTo(width)
            })
        }
    }
}

extension CommentCell {
    func configCell(_ comment: Comment) {
        profile.kf.setImage(
            with: URL(string: comment.iconBuddy),
            placeholder: nil,
            options: [],
            progressBlock: { receivedSize, totalSize in },
            completionHandler: { result in }
        )
        content.text = comment.content
        authorName.text = comment.authorName
        datecreate.text = comment.datecreate
        permalink.kf.setImage(
            with: URL(string: comment.permalink),
            placeholder: nil,
            options: [],
            progressBlock: { receivedSize, totalSize in },
            completionHandler: { result in }
        )
    }
}
