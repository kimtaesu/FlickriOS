//
//  LocationResult.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct LocationResult: Decodable, Equatable {
    let bbox: String
    let woeWoeId: String
    let latitude: String?
    let longitude: String?
    
    let city: String?
    let address: String?
    let state: String?
    let zip: String?
    let country: String?
    let woeSpecificprobability: String?
    let placeUrl: String?
    
    enum CoadingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case address = "Address"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case country = "Country"
        case woeWoeId = "woe_woeid"
        case woeSpecificprobability = "woe_specificprobability"
        case bbox = "woe_bbox"
        case placeUrl = "place_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoadingKeys.self)
        latitude = try? values.decode(String.self, forKey: .latitude)
        longitude = try? values.decode(String.self, forKey: .longitude)
        address = try? values.decode(String.self, forKey: .address)
        city = try? values.decode(String.self, forKey: .city)
        state = try? values.decode(String.self, forKey: .state)
        zip = try? values.decode(String.self, forKey: .zip)
        country = try? values.decode(String.self, forKey: .country)
        woeWoeId = try values.decode(String.self, forKey: .woeWoeId)
        woeSpecificprobability = try? values.decode(String.self, forKey: .woeSpecificprobability)
        bbox = try values.decode(String.self, forKey: .bbox)
        placeUrl = try? values.decode(String.self, forKey: .placeUrl)
    }
}
