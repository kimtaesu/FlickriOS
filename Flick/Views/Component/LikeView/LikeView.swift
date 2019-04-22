//
//  PopularView.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LikeView: XibView {
    @IBOutlet weak private var countView: UILabel!
    @IBOutlet weak private var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        countView.textColor = ColorName.colorDark
        imageView.tintColor = ColorName.colorPrimary
    }
    
    func setUp(_ viewModel: LikesViewModel) {
        countView.text = "\(viewModel.count)"
        imageView.image = viewModel.image.withRenderingMode(.alwaysTemplate)
    }
}

extension LikeView {
    @IBInspectable var countText: String? {
        get {
            return countView.text
        }
        set {
            countView.text = newValue
        }
    }

    @IBInspectable var likeImage: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
}
