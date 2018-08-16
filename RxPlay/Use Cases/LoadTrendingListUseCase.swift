//
//  LoadTrendingListUseCase.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

class LoadTrendingListUseCase: UseCase {

    let giphyRepository: GiphyRepository
    let remoteAPI: RemoteAPI

    init(giphyRepository: GiphyRepository,
         remoteAPI: RemoteAPI) {
        self.giphyRepository = giphyRepository
        self.remoteAPI = remoteAPI
    }

    func start() -> Completable {
        let requestObservable: Single<GIFListResponse> =
                remoteAPI.request(Route(.get, "v1/gifs/trending"))
        return requestObservable
            .do(onSuccess: {
                let newTrending = try self.giphyRepository.trending.value() + $0.data
                self.giphyRepository.trending.onNext(newTrending)
            })
            .asCompletable()
    }
}
