//
//  CategoryPresenter.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation

protocol ICategoryPresenter: AnyObject {
	func loadData()
	func tupButtonAdd()
}

final class CategoryPresenter: ICategoryPresenter {
	private var clouser: EmptyClosure?
	weak var viewController: ICategoryViewController?
	
	init(clouser: EmptyClosure?) {
		self.clouser = clouser
	}
	
	func loadData() {
		let model = MokData().categoryModel()
		let filter = MokData().categoryFilter()
		viewController?.viewReady(model: model, filter: filter)
	}
	
	func tupButtonAdd() {
		clouser?()
	}
}
