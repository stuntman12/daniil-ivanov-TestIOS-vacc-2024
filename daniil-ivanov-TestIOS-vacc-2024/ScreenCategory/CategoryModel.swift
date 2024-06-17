//
//  CategoryModel.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit

enum CategoryModel: Hashable {
	
	enum Section: Int, CaseIterable {
		case filterCards
		case autor
		case slim
	}

	enum TypePizza {
		case slim
		case autor
		
		var type: String {
			switch self {
			case .slim:
				return "Тонкое тесто"
			case .autor:
				return "Авторская пицца"
			}
		}
	}
	
	struct Filter: Hashable {
		let title: String
	}
	
	struct Card: Hashable {
		let id = UUID()
		let name: String
		let type: TypePizza
		let descriptionPizza: String
		let price: String
		let weight: String
		let image: String
		let calorie: String
		let protein: String
		let fats: String
		let carbohydrates: String
		let onion: String
		let tomato: String
		let cucumber: String
		let benefit: String
		let oldPrice: String
	}

}

