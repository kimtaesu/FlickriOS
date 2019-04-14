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

    let keywordView = PaddingLabel()
    let roundShadowView = RoundShadowView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundShadowView.do {
            $0.shadowOffset = CGSize(width: 0, height: 0.5)
            $0.backgroundColor = ColorName.lightGray
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        keywordView.do {
            $0.textColor = UIColor.black
            roundShadowView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
}

extension TextSubCell {
    func configCell(_ item: String) {
        keywordView.text = item
    }
}
