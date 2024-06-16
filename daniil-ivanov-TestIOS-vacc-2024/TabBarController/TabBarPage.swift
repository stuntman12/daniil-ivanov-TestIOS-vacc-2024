//
//  TabBarPage.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

enum TabbarPage {
	case main
	case basket
	
	func pageTitleValue() -> String {
		switch self {
		case .main:
			return "Главная"
		case .basket:
			return "Корзина"
		}
	}
	
	func pageIconValue() -> UIImage {
		switch self {
		case .main:
			return UIImage(resource: .icontabbarmain)
		case .basket:
			return UIImage(resource: .baskettabbarico)
		}
	}
	
	static let allTabbarPages: [TabbarPage] = [.main, .basket]
	static let firstTabbarPage: TabbarPage = .main
	
	var pageOrderNumber: Int {
		guard let num = TabbarPage.allTabbarPages.firstIndex(of: self) else { return .zero }
		return num
	}
}
