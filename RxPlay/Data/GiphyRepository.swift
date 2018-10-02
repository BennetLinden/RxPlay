//
//  GiphyRepository.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

final class GiphyRepository {

    private let remoteAPI: RemoteAPI

    init(remoteAPI: RemoteAPI) {
        self.remoteAPI = remoteAPI
    }
}

extension GiphyRepository: LoadTrendingListUseCase {

    func loadTrendingList() -> Observable<[GIF]> {
        let requestObservable: Single<GIFListResponse> =
            remoteAPI.request(Route(.get, "v1/gifs/trending"))
        return requestObservable.map({ $0.data }).asObservable()
    }
}

extension GiphyRepository: SearchUseCase {

    func search(query: String) -> Observable<[GIF]> {
        print("query: \(query)")
        let params: [String: Any] = ["q": query]
        let requestObservable: Single<GIFListResponse> =
            remoteAPI.request(Route(.get, "v1/gifs/search", with: params))
        return requestObservable.map({ $0.data }).asObservable()
    }
}
