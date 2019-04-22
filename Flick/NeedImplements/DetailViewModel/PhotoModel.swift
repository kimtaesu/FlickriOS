////
////  PhotoModel.swift
////  Flick
////
////  Created by tskim on 11/04/2019.
////  Copyright © 2019 hucet. All rights reserved.
////
//
//import Foundation
//import IGListKit
//
//class PhotoModel: PhotoType {
//    let id: String
//    let description: [String: String]?
//    let license: String?
//    let owner: String
//    let secret: String
//    let title: String
//    let ispublic: Int
//    let isfriend: Int
//    let isfamily: Int
//    let iconFarm: Int
//    let countComments: String
//    let countLikes: String
//    let views: String
//    let iconServer: String
//    let dateupload: String?
//    let lastupdate: String?
//    let datetaken: String?
//    let ownername: String?
//    let machine_tags: String?
//    let originalsecret: String?
//    let originalformat: String?
//    let latitude: Double?
//    let longitude: Double?
//    let accuracy: Int?
//    let media: String?
//    let media_status: String?
//    var imageSources: [ImageSource] = []
//
//    public init(_ photo: PhotoType) {
//        self.id = photo.id
//        self.description = photo.description
//        self.license = photo.license
//        self.owner = photo.owner
//        self.secret = photo.secret
//        self.title = photo.title
//        self.ispublic = photo.ispublic
//        self.isfriend = photo.isfriend
//        self.isfamily = photo.isfamily
//        self.iconFarm = photo.iconFarm
//        self.countComments = photo.countComments
//        self.countLikes = photo.countLikes
//        self.views = photo.views
//        self.iconServer = photo.iconServer
//        self.dateupload = photo.dateupload
//        self.lastupdate = photo.lastupdate
//        self.datetaken = photo.datetaken
//        self.ownername = photo.ownername
//        self.machine_tags = photo.machine_tags
//        self.originalsecret = photo.originalsecret
//        self.originalformat = photo.originalformat
//        self.latitude = photo.latitude
//        self.longitude = photo.longitude
//        self.accuracy = photo.accuracy
//        self.media = photo.media
//        self.media_status = photo.media_status
//        self.imageSources = photo.imageSources
//    }
//}
//
//extension PhotoModel: ListDiffable {
//    func diffIdentifier() -> NSObjectProtocol {
//        return "action" as NSObjectProtocol
//    }
//
//    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//        guard let object = object as? ActionViewModel else { return false }
//        return likes == object.likes
//    }
//}
