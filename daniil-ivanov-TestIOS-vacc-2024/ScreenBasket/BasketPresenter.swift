//
//  BasketPresenter.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation

protocol IBasketPresenter: AnyObject {
	func loadData()
}

final class BasketPresenter: IBasketPresenter {
	private weak var viewController: IBasketVewController?
	
	func loadData() {
		
	}
}
