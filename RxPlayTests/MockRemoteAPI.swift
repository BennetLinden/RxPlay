//
//  MockRemoteAPI.swift
//  RxPlayTests
//
//  Created by Bennet van der Linden on 10/10/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

@testable import RxPlay
import Foundation
import RxSwift

class MockRemoteAPI: RemoteAPI {
    
    let data = Data()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func request<T: Decodable>(_ route: Route) -> Single<T> {
        
        return Single<T>.create { single in
            do {
                single(.success(try self.decoder.decode(T.self, from: self.data)))
            } catch let error {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
