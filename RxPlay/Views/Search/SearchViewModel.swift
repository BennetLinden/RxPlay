//
//  SearchPresenter.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 17/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {

    private let searchObservable: Observable<[GIF]>
    var searchResults: Driver<[GIF]> {
        return searchObservable
            .asDriver(onErrorRecover: { [unowned self] error in
                self.error.onNext(error)
                return Driver.just([])
            })
    }

    private let error: PublishSubject<Error> = PublishSubject()
    var onError: Observable<Error> {
        return error.asObservable()
    }

    init(searchText: Driver<String>,
         searchButtonPressed: Signal<Void>,
         searchUseCase: SearchUseCase) {

        searchObservable = searchButtonPressed
            .withLatestFrom(searchText)
            .asObservable()
            .flatMapLatest { searchUseCase.search(query: $0) }
            .share(replay: 1, scope: .whileConnected)
    }
}
