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

    private let searchUseCase: SearchUseCase
    private let searchText: Driver<String>
    private let searchButtonPressed: Signal<Void>

    private let error: PublishSubject<Error> = PublishSubject()
    var onError: Observable<Error> {
        return error.asObservable()
    }

    lazy var searchResults: Driver<[GIF]> = {
        return searchButtonPressed
            .withLatestFrom(searchText)
            .asObservable()
            .flatMapLatest { self.searchUseCase.search(query: $0) }
            .asDriver(onErrorRecover: { [weak self] error in
                self?.error.onNext(error)
                return Driver.just([])
            })
    }()

    init(searchText: Driver<String>,
         searchButtonPressed: Signal<Void>,
         searchUseCase: SearchUseCase) {
        self.searchText = searchText
        self.searchButtonPressed = searchButtonPressed
        self.searchUseCase = searchUseCase
    }
}
