//
//  SearchUseCaseMock.swift
//  RxPlayTests
//
//  Created by Bennet van der Linden on 12/10/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

@testable import RxPlay
import RxSwift

private class ResultsSearchUseCaseMock: SearchUseCase {
    
    private let results: [GIF]
    
    init(results: [GIF]) {
        self.results = results
    }
    
    func search(query: String) -> Observable<[GIF]> {
        return Observable.just(results)
    }
}

private class FailingSearchUseCaseMock: SearchUseCase {
    
    private let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func search(query: String) -> Observable<[GIF]> {
        return Observable.error(error)
    }
}

enum SearchUseCaseMock {

    static func results(with results: [GIF]) -> SearchUseCase {
        return ResultsSearchUseCaseMock(results: results)
    }

    static func error(with error: Error) -> SearchUseCase {
        return FailingSearchUseCaseMock(error: error)
    }
}
