//
//  OrderHistoryViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var dataSource = HistoryDataSources()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties

    var viewModel: HistoryViewModel!
    
    // MARK: - Outlets

    @IBOutlet weak private  var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userID = UIDevice.current.identifierForVendor?.uuidString else { return }
        
        self.tableView.rowHeight = 204
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        bind(to: dataSource)

        bind(to: viewModel)
        viewModel.viewDidLoad(userID: userID)
    }

    // MARK: - Helpers
    
    private func bind(to viewModel: HistoryViewModel) {
        viewModel.items = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
    }
    
    private func bind(to dataSource: HistoryDataSources) {
        dataSource.didSelectItemAtIndex = viewModel.didSelectItem
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        guard let userID = UIDevice.current.identifierForVendor?.uuidString else { return }
        DispatchQueue.main.async {
            self.viewModel.findOrder(userID: userID)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }
}
