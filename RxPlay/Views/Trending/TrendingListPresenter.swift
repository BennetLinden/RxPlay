//
//  TrendingListPresenter.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

final class TrendingListPresenter: Presenter {

    private let loadTrendingListUseCaseFactory: LoadTrendingListUseCaseFactory
    private let disposeBag = DisposeBag()
    private let trendingListObservable: Observable<[GIF]>

    weak var view: TrendingListView?

    init(trendingListObservable: Observable<[GIF]>,
         loadTrendingListUseCaseFactory: LoadTrendingListUseCaseFactory) {
        self.trendingListObservable = trendingListObservable.distinctUntilChanged()
        self.loadTrendingListUseCaseFactory = loadTrendingListUseCaseFactory
    }

    func viewDidLoad() {
        trendingListObservable
            .subscribe(onNext: { [unowned self] trending in
                self.trendingChanged(to: trending)
            })
            .disposed(by: disposeBag)

        loadTrendingListUseCaseFactory.makeLoadTrendingListUseCase()
            .start()
            .subscribe(onError: { error in
                print("Error! \(error)")
            })
            .disposed(by: disposeBag)
    }

    private func trendingChanged(to trending: [GIF]) {
        view?.showUsernames(trending.map { $0.username })
    }
}
