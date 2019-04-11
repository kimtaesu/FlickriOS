//
//  CommentCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class CommentCell: UICollectionViewCell, ListBindable {
    let content = UILabel()
    let authorName = UILabel()
    let datecreate = UILabel()
    let permalink = UIImageView()
    let realname = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? CommentViewModel else { return }
        content.text = viewModel.content
        authorName.text = viewModel.authorName
        realname.text = viewModel.realname
        datecreate.text = viewModel.datecreate
        permalink.kf.setImage(
            with: URL(string: viewModel.permalink),
            placeholder: nil,
            options: [],
            progressBlock: { receivedSize, totalSize in },
            completionHandler: { result in }
        )
    }
}
