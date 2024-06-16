//
//  CardModel.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//

import Foundation

enum CardModel {
	enum Section: Int, CaseIterable, Hashable {
		case ingredients
	}
	
	struct PizzaInfo {
		let image: [String]
		let calorie: String
		let protein: String
		let fats: String
		let carbohydrates: String
		let ingredients: [CardModel.IngredientsCell]
		let price: String
	}
	
	struct IngredientsCell: Hashable {
		private let id = UUID()
		let image: String
		let title: String
		let weight: String
		let price: String
		let count: String
	}
	
}
