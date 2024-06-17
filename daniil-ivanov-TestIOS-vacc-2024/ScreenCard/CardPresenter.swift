//
//  CardPresenter.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

protocol ICardPresenter: AnyObject {
	func popViewController()
	func addProductBasket()
	func loadData()
}

final class CardPresenter: ICardPresenter {
	private var clouser: EmptyClosure?
	weak var viewController: ICardViewController?
	
	init(clouser: EmptyClosure?) {
		self.clouser = clouser
	}
	
	func popViewController() {
		clouser?()
	}
	
	func addProductBasket() {
		// Добавить в корзину
	}
	
	func loadData() {
		let model = MokData().cardModel()
		viewController?.viewReady(model: model)
	}
}
