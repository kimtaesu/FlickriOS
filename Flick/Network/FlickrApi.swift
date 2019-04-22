//
//  FlickrApi.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya

enum FlickrApi {
    case geoSearch(FkrGeoSearchReq)
    case findLocation(String)
    case getComments(FkrCommentRequest)
}

// swiftlint:disable force_try
extension FlickrApi: TargetType {
    var baseURL: URL { return URL(string: Enviroment.FLICKR_BASE_URL)! }

    var path: String {
        switch self {
        default:
            return "services/rest"
        }
    }

    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }

    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }

    var task: Task {
        var parameters = [String: Any]()
        switch self {
        case .findLocation(let text):
            parameters.updateValue(Method.findLocation.rawValue, forKey: Method.key)
            parameters.updateValue(text, forKey: "location")
        case .geoSearch(let req):
            parameters = try! req.tryAsDictionary()
            parameters.updateValue(Method.search.rawValue, forKey: Method.key)
            parameters.updateValue(Extras.geoAttrs, forKey: Extras.key)
        case .getComments(let req):
            parameters = try! req.tryAsDictionary()
            parameters.updateValue(Method.comment.rawValue, forKey: Method.key)
        }
        parameters.updateValue(Enviroment.FLICKR_API_KEY, forKey: "api_key")
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }

    var headers: [String: String]? {
        switch self {
        default: return [:]
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
