//
//  LL.swift
//  Flick
//
//  Created by tskim on 13/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class AddressLocationView: UIView {

    let city = UILabel()
    let state = UILabel()
    let country = UILabel()
    let switchMap = UIButton().then {
        $0.isHidden = true
    }

    var location: LocationResult? {
        willSet(newValue) {
            if let value = newValue {
                city.text = value.city
                state.text = value.state
                country.text = value.country
                switchMap.isHidden = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        country.do {
            addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.top.trailing.equalToSuperview()
            })
        }
        city.do {
            addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(country.snp.bottom)
                make.leading.equalTo(country.snp.leading)
            })
        }
        state.do {
            addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(city.snp.trailing)
                make.top.equalTo(city.snp.top)
            })
        }
        switchMap.do {
            $0.setImage(Asset.icMap.image, for: .normal)
            $0.tintColor = ColorName.colorAccent
            addSubview($0)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview()
                make.centerY.equalTo(country.snp.centerY)
            })
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
}
