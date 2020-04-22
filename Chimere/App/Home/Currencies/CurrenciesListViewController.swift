//
//  CurrenciesViewController.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class CurrenciesListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var dataSource = CurrenciesListDataSources()

    var viewModel: CurrenciesListViewModel!
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 50
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        bind(to: dataSource)
    }

    // MARK: - Helpers
    
    private func bind(to viewModel: CurrenciesListViewModel) {
        viewModel.items = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
    }
    
    private func bind(to dataSource: CurrenciesListDataSources) {
        dataSource.didSelectItemAtIndex = viewModel.didSelectItem
    }
}
