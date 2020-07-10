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
    
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Outlets

    @IBOutlet weak private var searchBar: UISearchBar!
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    
        setUI()
        
        bind(to: dataSource)
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func setUI() {
        let attributes = [NSAttributedString.Key.font : UIFont(name: "BodoniEgyptianPro-ExtBold", size: 12)!]
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: attributes)
        searchBar.searchTextField.font = UIFont(name: "BodoniEgyptianPro-ExtBold", size: 17)
    }

    // MARK: - Helpers

    private func bind(to viewModel: CurrenciesListViewModel) {
        viewModel.searchBarPlaceholderText = { [weak self] placeholder in
            DispatchQueue.main.async {
                self?.searchBar.placeholder = placeholder
            }
        }

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

extension CurrenciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearchCurrency(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
