//
//  MatchEndPoint.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation
import Alamofire

enum MatchEndPoint: Endpoint {
    case match
    var path: String {
        switch self {
        case .match:
            return "competitions/2021/matches/"
        }
    }
    var headers: HTTPHeaders {
        var headers = defaultHeaders
        return headers
    }
    var parameters: Parameters? {
        let param = defaultParams
        switch  self {
        case .match:
            break
        }
        return param
    }
    var method: HTTPMethod {
        switch self {
        case .match:
            return .get
        }
    }
}
