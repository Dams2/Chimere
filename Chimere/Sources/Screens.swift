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
    func didSelectHowItWork()
    func didSelectBoard()
}

extension Screens {
    func createExchangeViewController(delegate: ExchangeViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ExchangeViewController") as! ExchangeViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = ExchangeViewModel(delegate: delegate, repository: repository, translator: context.translator)
        viewController.viewModel = viewModel
        return viewController
    }
}

protocol BoardViewControllerDelegate: class {
    func didShowSignIn()
}
extension Screens {
    func createBoardViewController(delegate: BoardViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let viewModel = BoardViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createSignInViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let viewModel = SignInViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createHowItWorkViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "HowItWorkViewController") as! HowItWorkViewController
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
    func didSelectTermsOfUse()
}

extension Screens {
    func createOrderSummaryViewController(orderItems: [String: String], delegate: OrderSummaryViewControllerDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderSummaryViewController") as! OrderSummaryViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = OrderSummaryViewModel(orderItems: orderItems, delegate: delegate, repository: repository, translator: context.translator)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createTermsOfUseViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
        return viewController
    }
}

extension Screens {
    func createDepositViewController(deposit: Deposit, delegate: ExchangeViewControllerDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "DepositViewController") as! DepositViewController
        let repository = ExchangeRepository(client: context.client)
        let viewModel = DepositViewModel(deposit: deposit, repository: repository, delegate: delegate, translator: context.translator)
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
        let viewModel = HistoryViewModel(delegate: delegate, repository: repository, translator: context.translator)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createOrderDetailViewController(order: UserOrders) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        let viewModel = OrderDetailViewModel(order: order, translator: context.translator)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createFiatViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "FiatViewController") as! FiatViewController
        return viewController
    }
}

extension Screens {
    func createAlert(with configuration: AlertConfiguration) -> UIAlertController {
        let alertController = UIAlertController()
//        let attributesTitle = [NSAttributedString.Key.font : UIFont(name: "BodoniEgyptianPro-ExtBold", size: 15)!]
//        let attributesMessage = [NSAttributedString.Key.font : UIFont(name: "BodoniEgyptianPro-Medium", size: 12)!]
//        
        alertController.view.tintColor = #colorLiteral(red: 0.3529411765, green: 0.4509803922, blue: 0.007843137255, alpha: 1)
        
        alertController.title = configuration.title
        alertController.message = configuration.message
        let action = UIAlertAction(title: configuration.okMessage,
                                   style: .default,
                                   handler: nil)
//        alertController.setValue(NSAttributedString(string: alertController.title ?? "", attributes: attributesTitle), forKey: "attributedTitle")
//
//        alertController.setValue(NSAttributedString(string: alertController.message ?? "", attributes: attributesMessage), forKey: "attributedMessage")
//
//        alertController.setValue(NSAttributedString(string: alertController. ?? "", attributes: attributesMessage), forKey: "attributedMessage")
//
        alertController.addAction(action)
        return alertController
    }
}
