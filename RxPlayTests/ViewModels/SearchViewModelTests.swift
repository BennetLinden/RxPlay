//
//  SearchViewModelTests.swift
//  RxPlayTests
//
//  Created by Bennet van der Linden on 09/10/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import XCTest
@testable import RxPlay
import RxSwift
import RxCocoa
import RxTest

enum MockError: Error {
    case failed, test
}

class SearchViewModelTests: XCTestCase {
    
    private var mockResults: [GIF]!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        mockResults = Array.init(repeating: GIF.mock(), count: 10)
        super.setUp()
    }
    
    override func tearDown() {
        mockResults = nil
        super.tearDown()
    }
    
    func testEmptySearchText() {
        // 1. Given
        let searchText: Driver<String> = Driver.just("")
        let searchButtonPressed: Signal<Void> = Signal.just(())
        let searchUseCase = SearchUseCaseMock.results(with: [])
        
        // 2. When
        let viewModel = SearchViewModel(searchText: searchText,
                                        searchButtonPressed: searchButtonPressed,
                                        searchUseCase: searchUseCase)
        
        // 3. Then
        viewModel.searchResults
            .drive(onNext: { results in
                XCTAssert(results.isEmpty)
            })
            .disposed(by: disposeBag)
    }
    
    func testSearchWithFail() {
        // 1. Given
        let searchText: Driver<String> = Driver.just("")
        let searchButtonPressed: Signal<Void> = Signal.just(())
        let searchUseCase = SearchUseCaseMock.error(with: MockError.failed)
        
        // 2. When
        let viewModel = SearchViewModel(searchText: searchText,
                                        searchButtonPressed: searchButtonPressed,
                                        searchUseCase: searchUseCase)
        
        
        viewModel.onError
            .subscribe(onNext: { error in
                if case MockError.failed = error {
                    XCTAssert(true)
                } else {
                    XCTFail()
                }
            })
            .disposed(by: disposeBag)
        
        // 3. Then
        viewModel.searchResults
            .drive(onNext: { results in
                XCTAssert(results.isEmpty)
            })
            .disposed(by: disposeBag)
    }
    
    func testSearchWithResults() {
        // 1. Given
        let searchText: Driver<String> = Driver.just("mock")
        let searchButtonPressed: Signal<Void> = Signal.just(())
        let searchUseCase = SearchUseCaseMock.results(with: mockResults)
        
        // 2. When
        let viewModel = SearchViewModel(searchText: searchText,
                                        searchButtonPressed: searchButtonPressed,
                                        searchUseCase: searchUseCase)
        
        // 3. Then
        viewModel.searchResults
            .drive(onNext: { results in
                XCTAssertEqual(results, self.mockResults)
            })
            .disposed(by: disposeBag)
    }
    
    func testNoSearchButtonPressed() {
        // 1. Given
        let searchText: Driver<String> = Driver.just("asdasd")
        let searchButtonPressed: Signal<Void> = Signal.never()
        let searchUseCase = SearchUseCaseMock.results(with: mockResults)
        
        // 2. When
        let viewModel = SearchViewModel(searchText: searchText,
                                        searchButtonPressed: searchButtonPressed,
                                        searchUseCase: searchUseCase)
        
        // 3. Then
        viewModel.searchResults
            .asObservable()
            .subscribe({ _ in
                XCTFail()
            })
            .disposed(by: disposeBag)
        
        viewModel.onError
            .subscribe({ _ in
                XCTFail()
            })
            .disposed(by: disposeBag)
    }
}
