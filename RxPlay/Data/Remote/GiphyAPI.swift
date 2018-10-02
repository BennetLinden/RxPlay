//
//  GiphyAPI.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 16/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class GiphyAPI: RemoteAPI {

    private let host: URL = URL(string: "https://api.giphy.com/")!
    private let apiKey: [String: String] = ["api_key": "8tamH4rtZcex6xCsf3wAktYbtjo2IF4"]
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(_ route: Route) -> Single<T> {
        let request = RequestBuilder()
            .setMethod(route.method)
            .setEndpoint(host.appendingPathComponent(route.path))
            .setParams(route.parameters)
            .addParams(apiKey)
            .build()

        return RxAlamofire
            .request(request)
            .validate()
            .responseData()
            .do(
                onNext: { print($0.0)},
                onError: { print($0.localizedDescription) }
            )
            .map({ try self.decoder.decode(T.self, from: $0.1) })
            .asSingle()
    }
}
