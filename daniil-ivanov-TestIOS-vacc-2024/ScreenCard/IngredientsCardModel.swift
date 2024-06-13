//
//  IngredientsCardModel.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//

import Foundation

enum IngredientsCardModel {
	enum Section: Int, CaseIterable, Hashable {
		case ingredients
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
