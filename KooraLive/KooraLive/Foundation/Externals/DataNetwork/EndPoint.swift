//
//  EndPoint.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation
import Alamofire

protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: URL { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest { get }
}

extension Endpoint {
    var baseURL: String { "https://api.football-data.org/v2/" }
    
    var requestURL: URL { URL(string: baseURL + path)! }
    
    var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "X-Auth-Token", value: Constants.apiKey)
        return headers
    }
    
    var defaultParams: Parameters { Parameters() }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        try encoding.encode(urlRequest, with: parameters)
    }
}
