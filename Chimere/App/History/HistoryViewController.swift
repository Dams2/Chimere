//
//  OrderHistoryViewController.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    private lazy var dataSource = HistoryDataSources()

    var viewModel: HistoryViewModel!
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 204
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
//        let userID = UIDevice.current.
//        
//        print(userID.uuidString)
        
//        bind(to: viewModel)
    }

    // MARK: - Helpers
    
    private func bind(to viewModel: HistoryViewModel) {
//        viewModel.items = { [weak self] items in
//            DispatchQueue.main.async {
//                self?.dataSource.update(with: items)
//                self?.tableView.reloadData()
//            }
//        }
    }
    
}
