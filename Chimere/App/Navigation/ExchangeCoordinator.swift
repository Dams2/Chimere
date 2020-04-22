//
//  HomeCoordinator.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class ExchangeCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController

    private let screens: Screens
    
    private var exchangeViewController: UIViewController?

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }

    // MARK: - Coodinator

    func start() {
        showExchange()
    }

    private func showExchange() {
        exchangeViewController = screens.createExchangeViewController(delegate: self)
        guard let exchangeViewController = exchangeViewController else { return }
        presenter.viewControllers = [exchangeViewController]
    }
    
    private func showCurrenciesList() {
        let viewController = screens.createCurrenciesListViewController(delegate: self)
        presenter.showDetailViewController(viewController, sender: self)
    }

    private func showDeposit(deposit: Deposit) {
        let viewController = screens.createDepositViewController(deposit: deposit)
        presenter.pushViewController(viewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    func didShowCurrencieslist() {
        showCurrenciesList()
    }
    
    func didSelectExchangeNow(deposit: Deposit) {
        showDeposit(deposit: deposit)
    }
    
    func didPresentAlert(for alert: AlertType) {
        switch alert {
        case .badEntry(alertConfiguration: let configuration):
            let alertController = screens.createAlert(with: configuration)
            exchangeViewController?.present(alertController,
                                        animated: true)
        }
    }
}

extension ExchangeCoordinator: CurrenciesListViewControllerDelegate {
    func didSelect(_ currency: Currency) {

    }
}
