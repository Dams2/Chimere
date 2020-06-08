//
//  MainCoordinator.swift
//  antex
//
//  Created by Damien Rojo on 14.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case exchange = 0
//    case fiat = 1
    case history = 1
}

protocol TabBarSourceType {
    var items: [UINavigationController] { get set }
}

extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
}

fileprivate class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
//        UINavigationController(nibName: nil, bundle: nil)
    ]

    init() {
        let translator = Translator(with: "")
        self[.exchange].tabBarItem = UITabBarItem(title: translator.translate(key: "mobile/TabBar/exchange"), image: UIImage(systemName: "bitcoinsign.circle"), tag: 0)
//        self[.fiat].tabBarItem = UITabBarItem(title: "Fiat", image: UIImage(systemName: "dollarsign.circle"), tag: 1)
        self[.history].tabBarItem = UITabBarItem(title: translator.translate(key: "mobile/TabBar/history"), image: UIImage(systemName: "book.circle"), tag: 2)
    }
}


final class MainCoordinator: NSObject {

    // MARK: - Properties
    
    private let presenter: UIWindow

    private let tabBarController: UITabBarController

    private let screens: Screens

    private var homeCoordinator: ExchangeCoordinator?
    
    private var fiatCoordinator: FiatCoordinator?
    
    private var historyCoordinator: HistoryCoordinator?

    private var tabBarSource = TabBarSource()
    
    // MARK: - Init

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter

        screens = Screens(context: context)

        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = tabBarSource.items
        tabBarController.selectedViewController = tabBarSource[.exchange]

        super.init()

        tabBarController.delegate = self
    }

    // MARK: - Coordinator

    func start() {
        presenter.rootViewController = tabBarController
        showHome()
    }

    private func showHome() {
        homeCoordinator = ExchangeCoordinator(presenter: tabBarSource[.exchange], screens: screens)
        homeCoordinator?.start()
    }
    
    private func shopFiat() {
//        fiatCoordinator = FiatCoordinator(presenter: tabBarSource[.fiat], screens: screens)
        fiatCoordinator?.start()
    }
    
    private func showHistory() {
        historyCoordinator = HistoryCoordinator(presenter: tabBarSource[.history], screens: screens)
        historyCoordinator?.start()
    }
}

extension MainCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < tabBarSource.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Selected ViewController Index Out Of range")
        }

        switch item {
        case .exchange:
            showHome()
//        case .fiat:
//            shopFiat()
        case .history:
            showHistory()
        }
    }
}
