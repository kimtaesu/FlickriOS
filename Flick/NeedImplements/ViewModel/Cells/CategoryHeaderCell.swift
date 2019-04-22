//
//  CategoryHeaderCell.swift
//  Flick
//
//  Created by tskim on 02/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class CategoryHeaderCell: UICollectionViewCell, SwiftNameIdentifier {

    let titleView = UILabel()
    let moreView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initViews() {
        titleView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview().offset(20)
                make.centerY.equalToSuperview()
            })
        }
        moreView.do {
            contentView.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.textColor = ColorName.moreText
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview().offset(-20)
                make.centerY.equalToSuperview()
            })
        }
    }
}

extension CategoryHeaderCell {
    func configCell(_ title: String) {
        titleView.text = title
        moreView.text = "더보기"
    }
}
