//
//  HomeViewController.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}

extension HomeViewController: View, HasDisposeBag {

    func bind(reactor: HomeReactor) {
        reactor.action.onNext(.search("a"))
    }
}

extension HomeViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = HomeReactor(rootContainer.resolve(FlickrRepositoryType.self)!)
    }
}
