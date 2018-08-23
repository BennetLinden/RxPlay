//
//  SearchPresenter.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 17/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

final class SearchViewModel {

    let disposeBag = DisposeBag()
    let searchResults: Observable<[GIF]>

    init(searchTextObservable: Observable<String>,
         searchButtonObservable: Observable<Void>,
         searchUseCase: SearchUseCase) {

        searchResults = searchButtonObservable.withLatestFrom(searchTextObservable)
            .distinctUntilChanged()
            .flatMapLatest ({ (query: String) -> Observable<[GIF]> in
                return searchUseCase.search(query: query)
            })
    }
    
    
    func someFunction() {
        GiphyAPI().request(<#T##route: Route##Route#>)
    }
}
