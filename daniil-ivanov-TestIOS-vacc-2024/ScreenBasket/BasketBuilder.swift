//
//  BasketBuilder.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation

final class BasketBuilder {
	func assembly() -> BasketVewController {
		let viewController = BasketVewController()
		let presenter = BasketPresenter()
		viewController.presenter = presenter
		return viewController
	}
}
