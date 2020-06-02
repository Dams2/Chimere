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
    
    private lazy var dataSource: CurrenciesListDataSources = {
        let dataSource = CurrenciesListDataSources(tableView: self.tableView)
        return dataSource
    }()

    var viewModel: CurrenciesListViewModel!
    
    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: dataSource)
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        
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
