//
//  AppCoordinator.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	override func start() {
		runMainFlow()
	}
	
	func runMainFlow() {
		let tabBarController = TabBarViewController()
		tabBarController.tabBar.items?[1].badgeValue = "5"
		let coordinator = MainCoordinator(tabBarController: tabBarController)
		addChild(coordinator)
		coordinator.start()
		navigationController.isNavigationBarHidden = true
		navigationController.pushViewController(tabBarController, animated: true)
	}
}
