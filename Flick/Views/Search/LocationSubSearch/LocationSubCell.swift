//
//  LocationSubCell.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class LocationSubCell: UICollectionViewCell, SwiftNameIdentifier {

    let imageView = UIImageView()
    
    let city = UILabel()
    let state = UILabel()
    let country = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let margin = 6
        contentView.layer.do {
            $0.shadowColor = UIColor.black.cgColor
            $0.shadowOpacity = 0.3
            $0.shadowOffset = CGSize(width: 0, height: 2)
            $0.shadowRadius = 5
        }
        imageView.do {
            contentView.addSubview($0)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 4
            $0.image = Asset.toronto.image
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        
        state.do {
            contentView.addSubview($0)
            $0.textColor = UIColor.white
            $0.setTextSize(12)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(margin)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-10)
            })
        }
        city.do {
            contentView.addSubview($0)
            $0.textColor = UIColor.white
            $0.setTextSize(16)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(margin)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(state.snp.top)
            })
        }
        country.do {
            contentView.addSubview($0)
            $0.textColor = UIColor.white
            $0.setTextSize(20)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(margin)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(city.snp.top)
            })
        }
    }
}

extension LocationSubCell {
    func configCell(_ item: LocationResult) {
        state.text = item.state ?? " "
        city.text = item.city ?? " "
        country.text = item.country
    }
}
