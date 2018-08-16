//
//  DependencyContainer.swift
//  ReToedoes
//
//  Created by Bennet van der Linden on 25/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class DependencyContainer: DependencyProvider {

    let giphyRepository: GiphyRepository = GiphyRepository()
    let giphyAPI = GiphyAPI()

    func makeTrendingListViewController() -> UIViewController {
        return TrendingListViewController(presenter: makeTrendingListPresenter())
    }

    func makeTrendingListPresenter() -> TrendingListPresenter {
        return TrendingListPresenter(trendingListObservable: giphyRepository.trending,
                                     loadTrendingListUseCaseFactory: self)
    }

    func makeLoadTrendingListUseCase() -> UseCase {
        return LoadTrendingListUseCase(giphyRepository: giphyRepository,
                                       remoteAPI: giphyAPI)
    }
}
