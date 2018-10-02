//
//  TrendingListViewModelFactory.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 20/08/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation

protocol TrendingListViewModelFactory {
    func makeTrendingListViewModel() -> TrendingListViewModel
}
