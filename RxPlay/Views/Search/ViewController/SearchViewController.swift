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
import Reusable

final class SearchViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private let disposeBag = DisposeBag()
    private let viewModel: SearchViewModel

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        return searchController
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SearchViewController.self), bundle: .main)

        title = "Search"
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController

        tableView.register(cellType: GIFPreviewTableViewCell.self)
        tableView.estimatedRowHeight = 320
        tableView.rowHeight = UITableViewAutomaticDimension

        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        searchController.searchBar.rx.searchButtonClicked
            .bind(to: viewModel.searchButton)
            .disposed(by: disposeBag)

        viewModel.onError
            .subscribe(onNext: { (error) in
                let alertController = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Close", style: .default))
                self.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.searchResults
            .drive(tableView.rx.items) { (tableView, row, gif) in
                let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GIFPreviewTableViewCell.self)
                let url = URL(string: gif.images.downsized.url)!
                cell.previewImageView.setGifFromURL(url)
                cell.usernameLabel.text = gif.username
                cell.ratingLabel.text = String(format: "Rating: %@", gif.rating)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
