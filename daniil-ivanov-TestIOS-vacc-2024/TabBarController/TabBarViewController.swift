//
//  TabBarController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		settingTabBar()
	}
}

private extension TabBarViewController {
	func settingTabBar() {
		tabBar.backgroundColor = .white 
		let controllers : [UINavigationController] = TabbarPage.allTabbarPages.map {
			getTabController($0)
		}
		
		setViewControllers(controllers, animated: true)
		selectedIndex = TabbarPage.firstTabbarPage.pageOrderNumber
	}
	
	func getTabController(_ page: TabbarPage) -> UINavigationController {
		let navController = UINavigationController()
		
		navController.tabBarItem = UITabBarItem(
			title: page.pageTitleValue(),
			image: page.pageIconValue(),
			tag: page.pageOrderNumber
		)
		
		return navController
	}
}
