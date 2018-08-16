//
//  TrendingListViewController.swift
//  RxPlay
//
//  Created by Bennet van der Linden on 13/08/2018.
//  Copyright (c) 2018 Bennet. All rights reserved.
//
//

import UIKit

final class TrendingListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private var usernames: [String] = []

    private let presenter: TrendingListPresenter

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: TrendingListPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: TrendingListViewController.self), bundle: .main)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        tableView.dataSource = self
        presenter.viewDidLoad()
    }
}

extension TrendingListViewController: TrendingListView {

    func showUsernames(_ usernames: [String]) {
        self.usernames = usernames
        tableView.reloadData()
    }
}

extension TrendingListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = usernames[indexPath.row]
        return cell
    }
}
