//
//  LocationSubCell.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class LocationSubCell: UITableViewCell, SwiftNameIdentifier {

    let city = UILabel()
    let state = UILabel()
    let country = UILabel()
    let switchMap = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        country.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.top.trailing.equalToSuperview()
            })
        }
        city.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(country.snp.bottom)
                make.leading.equalTo(country.snp.leading)
            })
        }
        state.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(city.snp.trailing)
                make.top.equalTo(city.snp.top)
            })
        }
        switchMap.do {
            $0.setImage(Asset.icHome.image, for: .normal)
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview()
                make.centerY.equalTo(country.snp.centerY)
            })
        }
    }
}

extension LocationSubCell {
    func configCell(_ item: LocationResult) {
        country.text = item.country
        city.text = item.city
        state.text = item.state
    }
}
