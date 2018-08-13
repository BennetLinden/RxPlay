//
//  Requestable.swift
//  RePlay
//
//  Created by Bennet van der Linden on 25/05/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable: URLRequestConvertible {

    var method: Alamofire.HTTPMethod { get }
    var endpoint: URL { get }
    var parameters: [String: Any]? { get }

}

extension Requestable {

    private var encoding: Alamofire.ParameterEncoding {
        switch method {
        case .get: return Alamofire.URLEncoding.default
        default: return Alamofire.JSONEncoding.default
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let request: URLRequest = {
            var request = URLRequest(url: endpoint)
            request.httpMethod = method.rawValue
            return request
        }()
        return try encoding.encode(request, with: parameters)
    }
}
