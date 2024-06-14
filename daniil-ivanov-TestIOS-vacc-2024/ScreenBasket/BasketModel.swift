//
//  BasketModel.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 14.06.2024.
//

import Foundation

enum BasketModel {
	enum Section: Int, Hashable, CaseIterable {
		case product
	}
	
	struct Product: Hashable {
		private let id = UUID()
		let image: String
		let title: String
		let price: String
		let count: String
	}
}
