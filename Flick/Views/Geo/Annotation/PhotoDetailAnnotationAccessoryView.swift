//
//  PhotoAnnotationDetail.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
import UIKit

protocol PhotoAnnotationDelegate: class {
    func tapThumbnailView(_ annotaion: MKAnnotation)
}

class PhotoDetailAnnotationAccessoryView: UIView {

    let thumbnailView = UIImageView()
    weak var delegate: PhotoAnnotationDelegate?
    private let annotation: MKAnnotation
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(annotation: MKAnnotation) {
        self.annotation = annotation
        super.init(frame: .zero)
        
        thumbnailView.do {
            self.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints({ make in
                let width = 60
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.edges.equalToSuperview()
            })
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapThumbnail)))
        }
    }
    func setDelegate(_ delegate: PhotoAnnotationDelegate) {
        self.delegate = delegate
    }
    
    @objc
    func tapThumbnail() {
        self.delegate?.tapThumbnailView(self.annotation)
    }
}

extension PhotoDetailAnnotationAccessoryView {
    func configCell(_ annotation: PhotoAnnotation) {
        if let thumbnail = annotation.photo.nearHeightByWidth(width: 400) {
            thumbnailView.kf.setImage(
                with: URL(string: thumbnail.imageUrl),
                placeholder: nil,
                options: [],
                progressBlock: { receivedSize, totalSize in
                },
                completionHandler: { result in
                }
            )
        }
    }
}
