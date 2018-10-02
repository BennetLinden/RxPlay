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

    let searchUseCase: SearchUseCase

    let searchText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let searchButton: PublishSubject<Void> = PublishSubject()
    let onError: PublishSubject<Error> = PublishSubject()

    lazy var searchResults: Driver<[GIF]> = {
        return searchButton
            .withLatestFrom(searchText)
            .flatMapLatest { self.searchUseCase.search(query: $0) }
            .asDriver(onErrorRecover: { error in
                self.onError.onNext(error)
                return Driver.just([])
            })
    }()

    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
}
