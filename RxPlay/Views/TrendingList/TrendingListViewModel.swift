//
//  TrendingListPresenter.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendingListViewModel {

    private let trendingListObservable: Observable<[GIF]>
    var trendingList: Driver<[GIF]> {
        return trendingListObservable
            .asDriver(onErrorRecover: { [weak self] error in
                self?.error.onNext(error)
                return Driver.just([])
            })
    }

    private let error: PublishSubject<Error> = PublishSubject()
    var onError: Observable<Error> {
        return error.asObservable()
    }

    init(loadTrendingListUseCase: LoadTrendingListUseCase) {
        trendingListObservable = loadTrendingListUseCase
            .loadTrendingList()
            .share(replay: 1, scope: .whileConnected)
    }

}
