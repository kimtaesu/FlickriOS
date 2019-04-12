//
//  UserCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

class UserCell: UICollectionViewCell, ListBindable {
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
        guard let viewModel = viewModel as? UserViewModel else { return }
        dataTakenLabel.text = viewModel.datetaken
        userNameLabel.text = viewModel.ownerName
        profileImage.kf.setImage(
            with: URL(string: viewModel.iconBuddy),
            placeholder: nil,
            options: [],
            progressBlock: { receivedSize, totalSize in },
            completionHandler: { result in }
        )
    }
}
