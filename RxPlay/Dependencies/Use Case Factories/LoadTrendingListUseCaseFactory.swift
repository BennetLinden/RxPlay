//
//  LoadTrendingListUseCaseFactory.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation

protocol LoadTrendingListUseCaseFactory {
    func makeLoadTrendingListUseCase() -> UseCase
}
