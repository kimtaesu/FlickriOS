//
//  Photo.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
/*
s    작은 사각형 75x75
q    large square 150x150
t    썸네일, 가장 긴 면이 100
m    소형, 가장 긴 면이 240
n    small, 320 on longest side
-    중형, 가장 긴 면이 500
z    중형(가장 긴 면이 640)
c    중형 800(가장 긴 면이 800)†
b    대형(가장 긴 면이 1024)*
h    대형 1600, 가장 긴 면이 1600†
k    대형 2048, 가장 긴 면이 2048†
o    원본 이미지, 소스 형식에 따라 jpg, gif 또는png
*/

protocol PhotoType {
    var id: String { get }
    var description: [String: String]? { get }
    var license: String? { get }
    var owner: String { get }
    var secret: String { get }
    var title: String { get }
    var ispublic: Int { get }
    var isfriend: Int { get }
    var isfamily: Int { get }
    var iconFarm: Int { get }
    var countComments: Int { get }
    var countLikes: Int { get }
    var views: Int { get }
    var iconServer: String { get }
    var dateupload: String? { get }
    var lastupdate: String? { get }
    var datetaken: String? { get }
    var ownername: String? { get }
    var machine_tags: String? { get }
    var originalsecret: String? { get }
    var originalformat: String? { get }
    var latitude: Double? { get }
    var longitude: Double? { get }
    var accuracy: Int? { get }
    var media: String? { get }
    var media_status: String? { get }
    var imageSources: [ImageSource] { get }
}
struct Photo: PhotoType, Decodable, Equatable, ViewModelProtocol {
    let id: String
    let description: [String: String]?
    let license: String?
    let owner: String
    let secret: String
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let iconFarm: Int
    let countComments: Int
    let countLikes: Int
    let views: Int
    let iconServer: String
    let dateupload: String?
    let lastupdate: String?
    let datetaken: String?
    let ownername: String?
    let machine_tags: String?
    let originalsecret: String?
    let originalformat: String?
    let latitude: Double?
    let longitude: Double?
    let accuracy: Int?
    let media: String?
    let media_status: String?
    var imageSources: [ImageSource] = []
}

extension Photo {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        description = try? values.decode([String: String].self, forKey: .description)
        license = try? values.decode(String.self, forKey: .license)
        owner = try values.decode(String.self, forKey: .owner)
        iconFarm = try values.decode(Int.self, forKey: .iconfarm)
        iconServer = try values.decode(String.self, forKey: .iconserver)
        secret = try values.decode(String.self, forKey: .secret)
        title = try values.decode(String.self, forKey: .title)
        ispublic = try values.decode(Int.self, forKey: .ispublic)
        isfriend = try values.decode(Int.self, forKey: .isfriend)
        isfamily = try values.decode(Int.self, forKey: .isfamily)
        views = (try? values.decode(String.self, forKey: .views))?.toInt ?? 0
        countComments = (try? values.decode(String.self, forKey: .count_comments))?.toInt ?? 0
        countLikes = (try? values.decode(String.self, forKey: .count_faves))?.toInt ?? 0
        dateupload = try? values.decode(String.self, forKey: .dateupload)
        lastupdate = try? values.decode(String.self, forKey: .lastupdate)
        datetaken = try? values.decode(String.self, forKey: .datetaken)
        ownername = try? values.decode(String.self, forKey: .ownername)
        machine_tags = try? values.decode(String.self, forKey: .machine_tags)
        originalsecret = try? values.decode(String.self, forKey: .originalsecret)
        originalformat = try? values.decode(String.self, forKey: .originalformat)
        latitude = try values.decode(String.self, forKey: .latitude).toDouble
        longitude = try values.decode(String.self, forKey: .longitude).toDouble
        accuracy = try? values.decode(Int.self, forKey: .accuracy)
        media = try? values.decode(String.self, forKey: .media)
        media_status = try? values.decode(String.self, forKey: .media_status)

        if let url_sq = try? values.decode(String.self, forKey: .url_sq),
            let height_sq = (try? values.decode(String?.self, forKey: .height_sq)).toInt,
            let width_sq = (try? values.decode(String?.self, forKey: .width_sq)).toInt {
            imageSources.append(ImageSource(imageUrl: url_sq, width: width_sq, height: height_sq))
        }

        if let url_t = try? values.decode(String.self, forKey: .url_t),
            let height_t = (try? values.decode(String?.self, forKey: .height_t)).toInt,
            let width_t = (try? values.decode(String?.self, forKey: .width_t)).toInt {
            imageSources.append(ImageSource(imageUrl: url_t, width: width_t, height: height_t))
        }

        if let url_s = try? values.decode(String.self, forKey: .url_s),
            let height_s = (try? values.decode(String?.self, forKey: .height_s)).toInt,
            let width_s = (try? values.decode(String?.self, forKey: .width_s)).toInt {
            imageSources.append(ImageSource(imageUrl: url_s, width: width_s, height: height_s))
        }

        if let url_q = try? values.decode(String.self, forKey: .url_q),
            let height_q = (try? values.decode(String?.self, forKey: .height_q)).toInt,
            let width_q = (try? values.decode(String?.self, forKey: .width_q)).toInt {
            imageSources.append(ImageSource(imageUrl: url_q, width: width_q, height: height_q))
        }

        if let url_m = try? values.decode(String.self, forKey: .url_m),
            let height_m = (try? values.decode(String?.self, forKey: .height_m)).toInt,
            let width_m = (try? values.decode(String?.self, forKey: .width_m)).toInt {
            imageSources.append(ImageSource(imageUrl: url_m, width: width_m, height: height_m))
        }

        if let url_n = try? values.decode(String.self, forKey: .url_n),
            let height_n = (try? values.decode(String?.self, forKey: .height_n)).toInt,
            let width_n = (try? values.decode(String?.self, forKey: .width_n)).toInt {
            imageSources.append(ImageSource(imageUrl: url_n, width: width_n, height: height_n))
        }

        if let url_z = try? values.decode(String.self, forKey: .url_z),
            let height_z = (try? values.decode(String?.self, forKey: .height_z)).toInt,
            let width_z = (try? values.decode(String?.self, forKey: .width_z)).toInt {
            imageSources.append(ImageSource(imageUrl: url_z, width: width_z, height: height_z))
        }

        if let url_c = try? values.decode(String.self, forKey: .url_c),
            let height_c = (try? values.decode(String?.self, forKey: .height_c)).toInt,
            let width_c = (try? values.decode(String?.self, forKey: .width_c)).toInt {
            imageSources.append(ImageSource(imageUrl: url_c, width: width_c, height: height_c))
        }

        if let url_l = try? values.decode(String.self, forKey: .url_l),
            let height_l = (try? values.decode(String?.self, forKey: .height_l)).toInt,
            let width_l = (try? values.decode(String?.self, forKey: .width_l)).toInt {
            imageSources.append(ImageSource(imageUrl: url_l, width: width_l, height: height_l))
        }

        if let url_o = try? values.decode(String.self, forKey: .url_o),
            let height_o = (try? values.decode(String?.self, forKey: .height_o)).toInt,
            let width_o = (try? values.decode(String?.self, forKey: .width_o)).toInt {
            imageSources.append(ImageSource(imageUrl: url_o, width: width_o, height: height_o))
        }
    }
}

extension Photo {

    var location: CLLocationCoordinate2D {
        let location = CLLocationCoordinate2D(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
        logger.info("location: \(location)")
        return location
    }

    func nearHeightByWidth(width: Int) -> ImageSource? {
        return imageSources.min { image1, image2 in
            let distance1 = abs(width - image1.width)
            let distance2 = abs(width - image2.width)

            return distance1 < distance2
        }
    }
}
