//
//  NetworkError.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

struct ResponseError: Error, Decodable {
    var message: String
}

enum NetworkError: Error {
    case forbidden
    case somethingWentWrong
    case custom(ResponseError)
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .forbidden:
            return "Make sure you have permission to access this resource"
        case .somethingWentWrong:
            return "Something went wrong, please try again later"
        case let .custom(response):
            return response.message
        }
    }
}
