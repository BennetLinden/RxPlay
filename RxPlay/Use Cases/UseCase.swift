//
//  UseCase.swift
//  ReToedoes
//
//  Created by Bennet van der Linden on 25/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift

protocol UseCase {
    func start() -> Completable
}
