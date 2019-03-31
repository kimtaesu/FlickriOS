//
//  SearchViewController.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let uiSearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        uiSearchBar.do {
            let accessoryView = SearchInputAccessoryView().then {
                $0.bounds.size = CGSize(width: view.frame.width, height: 30)
            }
            $0.inputAccessoryView = accessoryView
            accessoryView.hideKeyboardButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
            view.addSubview($0)
            $0.placeholder = "Start search..."
            $0.snp.makeConstraints({ make in
                make.top.equalTo(self.safeAreaTop)
                make.leading.centerX.equalToSuperview()
            })
        }
    }

    @objc
    func hideKeyboard() {
        uiSearchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.uiSearchBar.becomeFirstResponder()
        }
    }
}
