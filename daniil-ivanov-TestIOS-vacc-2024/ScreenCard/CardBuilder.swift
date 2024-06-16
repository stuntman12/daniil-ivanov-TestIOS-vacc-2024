//
//  CardBuilder.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation

final class CardBuilder {
	func assembly(clouser: EmptyClosure?) -> CardViewController {
		let viewController = CardViewController()
		let presenter = CardPresenter(clouser: clouser)
		viewController.presenter = presenter
		return viewController
	}
}
