//
//  PopularView.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class PopularView: XibView {
    
    @IBOutlet weak private var uiStackView: UIStackView!
    @IBOutlet weak private var viewsView: LikeView!
    @IBOutlet weak private var likesView: LikeView!
    @IBOutlet weak private var commentsView: LikeView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(_ likes: [LikesViewModel]) {
        likes.forEach { viewModel in
            switch viewModel.type {
            case .comments:
                commentsView.setUp(viewModel)
            case .likes:
                likesView.setUp(viewModel)
            case .views:
                viewsView.setUp(viewModel)
            }
        }
    }
}
extension PopularView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}
