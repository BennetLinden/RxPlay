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
import RxCocoa

final class DependencyContainer: DependencyProvider {

    let giphyRepository: GiphyRepository = GiphyRepository(remoteAPI: GiphyAPI())

    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            makeTrendingListViewController(),
            makeSearchViewController()
        ]
        return tabBarController
    }

    func makeTrendingListViewController() -> UIViewController {
        let trendingListViewController = TrendingListViewController(viewModelFactory: self)
        return UINavigationController(rootViewController: trendingListViewController)
    }

    func makeTrendingListViewModel() -> TrendingListViewModel {
        return TrendingListViewModel(loadTrendingListUseCase: giphyRepository)
    }

    func makeSearchViewController() -> UIViewController {
        let searchViewController = SearchViewController(viewModelFactory: self)
        return UINavigationController(rootViewController: searchViewController)
    }

    func makeSearchViewModel(searchText: Driver<String>,
                             searchButtonPressed: Signal<Void>) -> SearchViewModel {
        return SearchViewModel(searchText: searchText,
                               searchButtonPressed: searchButtonPressed,
                               searchUseCase: giphyRepository)
    }
}
