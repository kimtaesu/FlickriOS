//
//  PhotoCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class PhotoCell: UICollectionViewCell, ListBindable {
    let userNameLabel = UILabel()
    let profileImage = UIImageView()
    let dataTakenLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? PhotoViewModel else { return }

        if let thumbnail = viewModel.imageSource?.imageUrl {
            profileImage.kf.setImage(
                with: URL(string: thumbnail),
                placeholder: nil,
                options: [],
                progressBlock: { receivedSize, totalSize in },
                completionHandler: { result in }
            )
        }
    }
}
