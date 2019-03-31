//
//  SearchInputAccessoryView.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class SearchInputAccessoryView: UIView {
    
    let hideKeyboardButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        hideKeyboardButton.do {
            addSubview($0)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            })
            $0.setImage(Asset.icHideKeyboard.image, for: .normal)
        }
    }
}
