//
//  TextSubCell.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class TextSubCell: UICollectionViewCell, SwiftNameIdentifier {

    let keywordView = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        keywordView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
            $0.sizeToFit()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keywordView.frame = bounds
    }
    
}

extension TextSubCell {
    func configCell(_ item: String) {
        keywordView.text = item
    }
}
