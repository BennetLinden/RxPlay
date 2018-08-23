//
//  TrendingListViewController.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//
//

import UIKit
import SwiftyGif
import RxSwift

final class TrendingListViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!
    private var trending: [GIF] = []

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let viewModel: TrendingListViewModel

    init(viewModelFactory: TrendingListViewModelFactory) {
        viewModel = viewModelFactory.makeTrendingListViewModel()
        super.init(nibName: String(describing: TrendingListViewController.self), bundle: .main)

        title = "Trending"
        tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: GIFPreviewTableViewCell.self)
        tableView.estimatedRowHeight = 320
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        
        viewModel.trendingList
            .subscribe(onNext: {
                self.trending = $0
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension TrendingListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trending.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GIFPreviewTableViewCell.self)
        let gif = trending[indexPath.row]
        let url = gif.images.downsized.url
        cell.previewImageView.setGifFromURL(url)
        cell.usernameLabel.text = gif.username
        cell.ratingLabel.text = String(format: "Rating: %@", gif.rating)
        return cell
    }
}
