//
//  HistoryDataSources.swift
//  Chimere
//
//  Created by Damien Rojo on 23.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryDataSources:  NSObject, UITableViewDelegate, UITableViewDataSource {

    typealias Item = UserOrders

    var didSelectItemAtIndex: ((Int) -> Void)?

    private var items: [Item] = []

    func update(with item: [Item]) {
        self.items = item
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.count > indexPath.item else {
            return UITableViewCell()
        }
        let order = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        cell.configure(with: order)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectItemAtIndex?(indexPath.item)
    }
}
