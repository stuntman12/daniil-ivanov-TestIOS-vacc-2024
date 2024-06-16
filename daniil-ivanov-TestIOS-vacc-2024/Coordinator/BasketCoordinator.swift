//
//  BasketCoordinator.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

final class BasketCoordinator: ICoordinator {
	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		runFlowBasket()
	}
	
	func runFlowBasket() {
		let viewController = BasketBuilder().assembly()
		navigationController.isNavigationBarHidden = true
		navigationController.pushViewController(viewController, animated: true)
	}
}
