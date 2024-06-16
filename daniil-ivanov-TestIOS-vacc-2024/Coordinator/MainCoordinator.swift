//
//  MainCoordinator.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
	private let tabBarController: UITabBarController
	private let pages: [TabbarPage] = TabbarPage.allTabbarPages

	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
	}

	
	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { item in
			guard let controller = item.element as? UINavigationController else { return }
			runMainFlow(item.offset, controller)
		}
	}
	
	func runMainFlow(_ index: Int, _ controller: UINavigationController) {
		let coordinator: ICoordinator
		switch pages[index] {
		case .main:
			coordinator = MenuCoordinator(navigationController: controller)
		case .basket:
			coordinator = BasketCoordinator(navigationController: controller)
		}
		addChild(coordinator)
		coordinator.start()
	}
}
