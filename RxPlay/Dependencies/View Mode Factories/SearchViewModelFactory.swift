//
//  SearchViewModelFactory.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 20/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchViewModelFactory {
    func makeSearchViewModel(searchTextObservable: Observable<String>,
                             searchButtonObservable: Observable<Void>) -> SearchViewModel
}
