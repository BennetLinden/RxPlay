//
//  TrendingListView.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//
//

import Foundation

protocol TrendingListView: View {
    func showUsernames(_ usernames: [String])
}
