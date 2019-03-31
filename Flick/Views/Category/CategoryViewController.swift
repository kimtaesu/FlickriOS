//
//  SearchViewController.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Hero
import ReactorKit
import UIKit

class CategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}

extension CategoryViewController: View, HasDisposeBag {
    func bind(reactor: CategoryReactor) {
    }
}

extension CategoryViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
}
