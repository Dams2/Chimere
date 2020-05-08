//
//  Screens.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

public class Screens {
    
    let context: Context

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))

    init(context: Context) {
       self.context = context
    }
}

protocol ExchangeViewControllerDelegate: class {
    func didshowExchange()
    func didShowOriginCurrenciesList()
    func didShowDestinationCurrencies()
    func didDismissCurrenciesList()
    func didSelectExchangeNow(orderItems: [String: String])
    func didPresentAlert(for alert: AlertType)
}

extension Screens {
    func createExchangeViewController(delegate: ExchangeViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ExchangeViewController") as! ExchangeViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = ExchangeViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

protocol CurrenciesListViewControllerDelegate: class {
    func didSelect(_ currency: Currency)
}

extension Screens {
    func createCurrenciesListViewController(delegate: CurrenciesListViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrenciesListViewController") as! CurrenciesListViewController
        let repository = CurrenciesListRepository(client: context.client)
        let viewModel = CurrenciesListViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

protocol OrderSummaryViewControllerDelegate: class {
    func didSelectConfirm(deposit: Deposit)
}

extension Screens {
    func createOrderSummaryViewController(orderItems: [String: String], delegate: OrderSummaryViewControllerDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderSummaryViewController") as! OrderSummaryViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = OrderSummaryViewModel(orderItems: orderItems, delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createDepositViewController(deposit: Deposit, delegate: ExchangeViewControllerDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "DepositViewController") as! DepositViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = DepositViewModel(deposit: deposit, repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

protocol HistoryViewControllerDelegate: class {
    func didSelect(_ order: UserOrders)
    func didShowExchange()
}

extension Screens {
    func createHistoryViewController(delegate: HistoryViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        let repository = HistoryRepository(client: context.client)
        let viewModel = HistoryViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createOrderDetailViewController(order: UserOrders) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        let viewModel = OrderDetailViewModel(order: order)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createAlert(with configuration: AlertConfiguration) -> UIAlertController {
        let alertController = UIAlertController()
        alertController.title = configuration.title
        alertController.message = configuration.message
        let action = UIAlertAction(title: configuration.okMessage,
                                   style: .default,
                                   handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
