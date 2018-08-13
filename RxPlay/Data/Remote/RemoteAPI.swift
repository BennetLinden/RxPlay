//
//  RemoteAPI.swift
//  RePlay
//
//  Created by Bennet van der Linden on 25/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class RemoteAPI {

    func request(_ route: Requestable) -> Promise<Data> {
        return Promise { seal in
            Alamofire.request(route)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data)

                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
}
