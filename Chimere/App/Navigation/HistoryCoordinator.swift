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
        let viewController = screens.createHistoryViewController()
        presenter.viewControllers = [viewController]
    }
}
