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
        let actions: ExchangeViewModel.Actions = .init(
            didPresentExchange: {
                self.showExchange()
        },
            didSelectBoard: {
                self.showBoard()
        },
            didSelectHowItWork: {
                self.showHowItWork()
        },
            didSelectOriginCurrency: {
                self.selectedCurrency = .origin
                self.showCurrenciesList()
        },
            didSelectDestinationCurrency: {
                self.selectedCurrency = .destination
                self.showCurrenciesList()
        },
            didDismissCurrenciesList: {
                self.dismissCurrenciesList()
        },
            didSelectExchangeNow: { (items) in
                self.showOrderSummary(orderItems: items)
        },
            didPresentAlert: { (alert) in
                self.didPresentAlert(for: .badEntry(alertConfiguration: alert))
        } )

        exchangeViewController = screens.createExchangeViewController(actions: actions)
        guard let exchangeViewController = exchangeViewController else { return }
        presenter.viewControllers = [exchangeViewController]
    }
    
    private func showBoard() {
        let viewController = screens.createBoardViewController(delegate: self)
        viewController.hidesBottomBarWhenPushed = true
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showSignIn() {
        let viewController = screens.createSignInViewController()
        presenter.pushViewController(viewController, animated: true)
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
        viewController.hidesBottomBarWhenPushed = true
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showTermsOfUse() {
        let viewController = screens.createTermsOfUseViewController()
        presenter.showDetailViewController(viewController, sender: self)
    }
    
    private func showDeposit(deposit: Deposit) {
        let actions: DepositViewModel.Actions = .init {
            self.showExchange()
        }
        let viewController = screens.createDepositViewController(actions: actions, deposit: deposit)
        presenter.pushViewController(viewController, animated: true)
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

extension ExchangeCoordinator: BoardViewControllerDelegate {
    func didShowSignIn() {
        showSignIn()
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
