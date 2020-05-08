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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var emptyOrdersView: UIView!
    
    @IBOutlet weak private var emptyOrderLabel: UILabel!
    
    @IBOutlet weak private var exchangeNowButton: UIButton!
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userID = UIDevice.current.identifierForVendor?.uuidString else { return }
        
        self.tableView.rowHeight = 204
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.refreshControl = refreshControl
        
        exchangeNowButton.isEnabled = false
        
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        bind(to: dataSource)

        bind(to: viewModel)
        viewModel.viewDidLoad(userID: userID)
        
        setUI()
    }

    // MARK: - Helpers
    
    private func bind(to viewModel: HistoryViewModel) {
        viewModel.loadingState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .isTrue:
                    self?.activityIndicator.startAnimating()
                case .isFalse:
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = false
                case .isEmpty:
                    self?.activityIndicator.stopAnimating()
                    self?.emptyOrdersView.isHidden = false
                }
            }
        }
        
        viewModel.emptyOrderText = { [weak self] text in
            self?.emptyOrderLabel.text = text
        }
        
        viewModel.exchangeNowText = { [weak self] text in
            self?.exchangeNowButton.setTitle(text, for: .normal)
        }
        
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
        activityIndicator.isHidden = true
        guard let userID = UIDevice.current.identifierForVendor?.uuidString else { return }
        DispatchQueue.main.async {
            self.viewModel.findOrder(userID: userID)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Actions
    
    @IBAction private func didPressExchangeNowButton(_ sender: UIButton) {
        viewModel.didPressExchangeNow()
    }
}
