//
//  TrendingListPresenter.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

final class TrendingListViewModel {

    let trendingList: Observable<[GIF]>

    init(loadTrendingListUseCase: LoadTrendingListUseCase) {
        trendingList = loadTrendingListUseCase.loadTrendingList()
    }

}
