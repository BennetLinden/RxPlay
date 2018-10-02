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

    private let loadTrendingListUseCase: LoadTrendingListUseCase
    lazy var trendingList: Driver<[GIF]> = {
        loadTrendingListUseCase
            .loadTrendingList()
            .asDriver(onErrorRecover: { [weak self] error in
                self?.error.onNext(error)
                return Driver.just([])
            })
    }()

    private let error: PublishSubject<Error> = PublishSubject()
    var onError: Observable<Error> {
        return error.asObservable()
    }

    init(loadTrendingListUseCase: LoadTrendingListUseCase) {
        self.loadTrendingListUseCase = loadTrendingListUseCase
    }

}
