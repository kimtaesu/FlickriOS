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
//    case search(FkrSearchRequest)
//    https://api.flickr.com/services/rest?sort=relevance&parse_tags=1&content_type=7&extras=can_comment%2Ccount_comments%2Ccount_faves%2Cdescription%2Cisfavorite%2Clicense%2Cmedia%2Cneeds_interstitial%2Cowner_name%2Cpath_alias%2Crealname%2Crotation%2Curl_c%2Curl_l%2Curl_m%2Curl_n%2Curl_q%2Curl_s%2Curl_sq%2Curl_t%2Curl_z&per_page=25&page=1&lang=ko-KR&text=a&viewerNSID=&method=flickr.photos.search&csrf=&api_key=0885d7a5db271e9bc9d09cbb3a453460&format=json&hermes=1&hermesClient=1&reqId=1a3ad451&nojsoncallback=1
//    case recent(FkrRecentRequest)
//    case interestings(FkrRecentRequest)
//    case getComments(FkrCommentRequest)

//    case searchGroups()
//    https://api.flickr.com/services/rest?extras=datecreate%2Cdate_activity%2Ceighteenplus%2Cinvitation_only%2Cneeds_interstitial%2Cnon_members_privacy%2Cpool_pending_count%2Cprivacy%2Cmember_pending_count%2Cicon_urls%2Cdate_activity_detail%2Cuse_vespa%2Cmembership_info%2Chas_pending_invite%2Csecure_rules&per_page=50&page=1&secure_image_embeds=1&filter_inactive_groups=1&sort=relevance&id=text%3Daa&text=aa&subscription_types=1%2C2%2C3%2C4&viewerNSID=&method=flickr.groups.search&csrf=&api_key=0885d7a5db271e9bc9d09cbb3a453460&format=json&hermes=1&hermesClient=1&reqId=d41480d8&nojsoncallback=1
    
//    case searchPeoples()
//    https://api.flickr.com/services/rest?username=a&exact=0&extras=path_alias rev_ignored rev_contacts is_pro location rev_contact_count Cuse_vespa Cdate_joined&per_page=50&page=1&show_more=1&perPage=50&loadFullContact=1&viewerNSID=&method=flickr.people.search&csrf=&api_key=0885d7a5db271e9bc9d09cbb3a453460&format=json&hermes=1&hermesClient=1&reqId=d026aab1&nojsoncallback=1
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
//        case .getComments(let req):
//            parameters = try! req.tryAsDictionary()
//            parameters.updateValue(Method.comment.rawValue, forKey: Method.key)
//        case .interestings(let req):
//            parameters = try! req.tryAsDictionary()
//            parameters.updateValue(Method.interesting.rawValue, forKey: Method.key)
//            parameters.updateValue(Extras.allAttrs, forKey: Extras.key)
//        case .recent(let req):
//            parameters = try! req.tryAsDictionary()
//            parameters.updateValue(Method.recent.rawValue, forKey: Method.key)
//            parameters.updateValue(Extras.allAttrs, forKey: Extras.key)
//        case .search(let req):
            // TODO catchs try syntax
//            parameters = try! req.tryAsDictionary()
//            parameters.updateValue(Method.search.rawValue, forKey: Method.key)
//            parameters.updateValue(Extras.allAttrs, forKey: Extras.key)
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
