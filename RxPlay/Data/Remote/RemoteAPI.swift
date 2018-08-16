//
//  RemoteAPI.swift
//  RePlay
//
//  Created by Bennet van der Linden on 25/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

protocol RemoteAPI {
    func request<T: Decodable>(_ route: Route) -> Single<T>
}
