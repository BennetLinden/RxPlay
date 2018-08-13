//
//  Route.swift
//  RePlay
//
//  Created by Bennet van der Linden on 20/05/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import Alamofire

struct Route: Requestable {

    let method: HTTPMethod
    let endpoint: URL
    let parameters: [String: Any]?

    init(_ method: HTTPMethod, _ endpoint: URL, with params: [String: Any]? = nil) {
        self.method = method
        self.endpoint = endpoint
        self.parameters = params
    }
}
