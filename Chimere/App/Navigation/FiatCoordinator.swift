//
//  FiatCoordinator.swift
//  Chimere
//
//  Created by Damien Rojo on 05.06.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

final class FiatCoordinator {
    
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
        showfiat()
    }

    private func showfiat() {
        let viewController = screens.createFiatViewController()
        presenter.viewControllers = [viewController]
    }
}
