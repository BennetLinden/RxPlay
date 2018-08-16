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

protocol DependencyProvider: TrendingListViewControllerFactory, LoadTrendingListUseCaseFactory {

    var giphyRepository: GiphyRepository { get }

    func makeTrendingListViewController() -> UIViewController
    func makeTrendingListPresenter() -> TrendingListPresenter
    func makeLoadTrendingListUseCase() -> UseCase
}
