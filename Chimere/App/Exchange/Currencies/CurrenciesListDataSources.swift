//
//  CurrenciesListDataSources.swift
//  antex
//
//  Created by Damien Rojo on 16.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class CurrenciesListDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    typealias Item = Currency
    
    var didSelectItemAtIndex: ((Int) -> Void)?

    init(tableView: UITableView) {
        super.init()

        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
    }

    private var items: [Item] = []
    
    private var filteredItems: [Item] = []

    func update(with item: [Item]) {
        self.items = item
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.count > indexPath.item else {
            return UITableViewCell()
        }
            
        let currency = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrenciesTableViewCell", for: indexPath) as! CurrenciesTableViewCell
        cell.configure(with: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        didSelectItemAtIndex?(indexPath.item)
    }
}

extension CurrenciesListDataSources: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, tableView: UITableView) {
        filteredItems = items.filter({ (currency) -> Bool in
            guard let text = searchBar.text else { return false }
            return currency.name.contains(text)
        })
        print(filteredItems)
    }
}
