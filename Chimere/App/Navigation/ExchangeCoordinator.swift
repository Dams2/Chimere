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
    
    private var currenciesListViewController: CurrenciesListViewController?

    private enum SelectedCurrency {
        case origin
        case destination
    }

    private var selectedCurrency: SelectedCurrency?

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
    
    private func showHowItWork() {
        let viewController = screens.createHowItWorkViewController()
        presenter.showDetailViewController(viewController, sender: self)
    }
    
    private func showCurrenciesList() {
        let viewController = screens.createCurrenciesListViewController(delegate: self)
        presenter.showDetailViewController(viewController, sender: self)
    }
    
    private func dismissCurrenciesList() {
        presenter.dismiss(animated: true, completion: nil)
    }
    
    private func showOrderSummary(orderItems: [String: String]) {
        let viewController = screens.createOrderSummaryViewController(orderItems: orderItems, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showTermsOfUse() {
        let viewController = screens.createTermsOfUseViewController()
        presenter.showDetailViewController(viewController, sender: self)
    }
    
    private func showDeposit(deposit: Deposit) {
        let viewController = screens.createDepositViewController(deposit: deposit, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func didshowExchange() {
        showExchange()
    }
    
    func didSelectHowItWork() {
        showHowItWork()
    }
    
    func didShowOriginCurrenciesList() {
        selectedCurrency = .origin
        showCurrenciesList()
    }

    func didShowDestinationCurrencies() {
        selectedCurrency = .destination
        showCurrenciesList()
    }
    
    func didDismissCurrenciesList() {
        dismissCurrenciesList()
    }

    func didSelectExchangeNow(orderItems: [String: String]) {
        showOrderSummary(orderItems: orderItems)
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
        guard
            let selectedCurrency = selectedCurrency,
            let exchangeViewController = exchangeViewController as? ExchangeViewController
            else { return }
        switch selectedCurrency {
        case .origin:
            exchangeViewController.updateOrigin(currency: currency)
        case .destination:
            exchangeViewController.updateDestination(currency: currency)
        }
    }
}

extension ExchangeCoordinator: OrderSummaryViewControllerDelegate {
    func didSelectConfirm(deposit: Deposit) {
        showDeposit(deposit: deposit)
    }
    
    func didSelectTermsOfUse() {
        showTermsOfUse()
    }
}
