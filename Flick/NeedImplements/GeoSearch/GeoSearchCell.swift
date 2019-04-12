//
//  GeoSearchCell.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class GeoSearchCell: UITableViewCell, SwiftNameIdentifier {

    let tickerImageView = UIImageView()
    let titleView = UILabel()
    let messageView = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tickerImageView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                let width = 20
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
            })
        }
        
        titleView.do {
            contentView.addSubview($0)
            $0.textColor = UIColor.black
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(tickerImageView.snp.trailing)
                make.trailing.equalToSuperview()
                make.top.equalToSuperview()
            })
        }
        messageView.do {
            contentView.addSubview($0)
            $0.textColor = UIColor.lightGray
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(titleView.snp.leading)
                make.top.equalTo(titleView.snp.bottom)
                make.trailing.equalToSuperview()
            })
        }
    }
}

extension GeoSearchCell {
    func configCell(_ item: GeoSearchOption) {
        tickerImageView.image = item.tickerImage
        titleView.text = item.title
        messageView.text = item.message
    }
}
