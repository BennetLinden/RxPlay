//
//  DependencyProvider.swift
//  ReToedoes
//
//  Created by Bennet van der Linden on 25/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol DependencyProvider: TabBarControllerFactory,
    TrendingListViewControllerFactory, TrendingListViewModelFactory,
    SearchViewControllerFactory, SearchViewModelFactory {

    var giphyRepository: GiphyRepository { get }

    func makeTabBarController() -> UITabBarController

    func makeTrendingListViewController() -> UIViewController
    func makeTrendingListViewModel() -> TrendingListViewModel

    func makeSearchViewController() -> UIViewController
    func makeSearchViewModel(searchText: Driver<String>,
                             searchButtonPressed: Signal<Void>) -> SearchViewModel
}
