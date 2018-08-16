//
//  Route.swift
//  RePlay
//
//  Created by Bennet van der Linden on 20/05/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import Alamofire

struct Route {

    let method: HTTPMethod
    let path: String
    let parameters: [String: Any]?

    init(_ method: HTTPMethod, _ path: String, with params: [String: Any]? = nil) {
        self.method = method
        self.path = path
        self.parameters = params
    }
}
