//
//  OrderHistory.swift
//  Chimere
//
//  Created by Damien Rojo on 21.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class HistoryCoordinator {
    
    // MARK: - Properties

    private let presenter: UINavigationController

    private let screens: Screens
    
    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }

    // MARK: - Coodinator

    func start() {
        showOrderHistory()
    }

    private func showOrderHistory() {
        let actions: HistoryViewModel.Actions = .init {
            self.showExchange()
        }
        
        let viewController = screens.createHistoryViewController(actions: actions, delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showExchange() {
        let action: ExchangeViewModel.Actions = .init(
            didPresentExchange: { },
            didSelectBoard: { },
            didSelectHowItWork: { },
            didSelectOriginCurrency: { },
            didSelectDestinationCurrency: { },
            didDismissCurrenciesList: { },
            didSelectExchangeNow: { _ in },
            didPresentAlert: { _ in }
        )
        
        let viewController = screens.createExchangeViewController(actions: action)
        presenter.viewControllers = [viewController]
    }
    
    private func showOrderDetail(order: UserOrders) {
        let viewController = screens.createOrderDetailViewController(order: order)
        presenter.showDetailViewController(viewController, sender: self)
    }
}

extension HistoryCoordinator: HistoryViewControllerDelegate {
    func didSelect(_ order: UserOrders) {
        showOrderDetail(order: order)
    }
    
    func didShowExchange() {
        showExchange()
    }
}
