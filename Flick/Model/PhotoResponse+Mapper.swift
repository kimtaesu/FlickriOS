//
//  PhotoResponse+Mapper.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension PhotoResponse {
    func mapThumbnail(width: Int) -> [Thumbnail] {
        return self.photos.photo.map {
            let fixImageSource = $0.findResolutionByWidth(width: width) ?? ImageSource(imageUrl: "", width: 0, height: 0)
            return Thumbnail(thumbnail: fixImageSource, original: fixImageSource, id: $0.id)
        }
    }
}
