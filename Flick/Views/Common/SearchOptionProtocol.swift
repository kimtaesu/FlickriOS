//
//  SearchOptionProtocol.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

protocol SearchOptionProtocol {
    var tickerImageView: UIImageView { get }
    var titleView: UILabel { get }
    var searchFieldView: UITextField { get }
    var doneButton: UIButton { get }
}

extension SearchOptionProtocol where Self: UIViewController {
    func setUpSearchView() {
        tickerImageView.do {
            view.addSubview($0)
            $0.image = Asset.icTextFormat.image
            $0.snp.makeConstraints({ make in
                let width = 30
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(safeAreaTop).offset(20)
            })
        }
        doneButton.do {
            view.addSubview($0)
            $0.setTitle(L10n.titleDone, for: .normal)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview().offset(-20)
                make.top.equalTo(tickerImageView.snp.top)
            })
        }
        titleView.do {
            view.addSubview($0)
            $0.setTextSize(20)
            $0.text = L10n.geoSearchOptionsTextTitle
            $0.textColor = UIColor.black
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(tickerImageView.snp.trailing).offset(20)
                make.centerY.equalTo(tickerImageView.snp.centerY)
                make.trailing.equalToSuperview().offset(20)
            })
        }
        searchFieldView.do {
            view.addSubview($0)
            $0.textColor = UIColor.gray
            $0.placeholder = L10n.geoSearchOptionsLocationMessage
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(titleView.snp.leading)
                make.top.equalTo(titleView.snp.bottom).offset(16)
                make.trailing.equalTo(doneButton.snp.trailing)
            })
        }
    }
}
