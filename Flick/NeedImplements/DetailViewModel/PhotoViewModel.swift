//
//  Photo+ListDiffable.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

final class PhotoViewModel {
    let id: String
    let imageSource: ImageSource?
    
    init(_ photo: Photo) {
        self.id = photo.id
        self.imageSource = photo.nearHeightByWidth(width: 400)
    }
}
