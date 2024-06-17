//
//  CategoryBuilder.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation

final class CategoryBuilder {
	func assembly(clouser: EmptyClosure?) -> CategoryViewController {
		let viewController = CategoryViewController()
		let presenter = CategoryPresenter(clouser: clouser)
		presenter.viewController = viewController
		viewController.presenter = presenter
		return viewController
	}
}
