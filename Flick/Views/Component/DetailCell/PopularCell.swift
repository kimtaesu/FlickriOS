//
//  PopularCell.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class PopularCell: UICollectionViewCell, ListBindable {

    let countComments = UILabel()
    let countLikes = UILabel()
    let viewsLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? PopularViewModel else { return }
        countComments.text = viewModel.countComments
        countLikes.text = viewModel.countLikes
        viewsLabel.text = viewModel.views
    }
}
