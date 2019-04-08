//
//  PhotoGeoViewController.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import UIKit

class PhotoGeoViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        reactor = PhotoGeoReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension PhotoGeoViewController: View, HasDisposeBag {
    func bind(reactor: PhotoGeoReactor) {
        reactor.action.onNext(.fetchPhotosGeo(""))
    }
}
