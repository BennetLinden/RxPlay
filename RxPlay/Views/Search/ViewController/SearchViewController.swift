//
//  SearchViewController.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 17/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {

    let disposeBag = DisposeBag()

    let viewModel: SearchViewModel

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        return searchController
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModelFactory: SearchViewModelFactory) {
        viewModel = viewModelFactory.makeSearchViewModel(
            searchTextObservable: searchController.searchBar.rx.text.orEmpty.distinctUntilChanged(),
            searchButtonObservable: searchController.searchBar.rx.searchButtonClicked.asObservable()
        )
        super.init(nibName: String(describing: SearchViewController.self), bundle: .main)

        title = "Search"
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationItem.searchController = searchController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.searchResults
            .subscribe(onNext: { print($0.map({ $0.images.downsized.url	 })) })
            .disposed(by: disposeBag)
    }
}
