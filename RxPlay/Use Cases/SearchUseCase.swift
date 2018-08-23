//
//  SearchUseCase.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 17/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func search(query: String) -> Observable<[GIF]>
}
