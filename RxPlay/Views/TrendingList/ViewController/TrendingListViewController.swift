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
import RxCocoa

final class TrendingListViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!

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

        viewModel.onError
            .subscribe(onNext: { (error) in
                let alertController = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Close", style: .default))
                self.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.trendingList
            .drive(tableView.rx.items) { (tableView, row, gif) in
                let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GIFPreviewTableViewCell.self)
                if let url = URL(string: gif.images.downsized.url) {
                    cell.previewImageView.setGifFromURL(url)
                }
                cell.usernameLabel.text = gif.username
                cell.ratingLabel.text = String(format: "Rating: %@", gif.rating)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
