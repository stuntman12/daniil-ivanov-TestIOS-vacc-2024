//
//  CategoryModel.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit

enum CategoryModel: Hashable {
	
	enum Section: Int, CaseIterable {
		case filterCard
		case card
	}
	
	struct Card: Hashable {
		let id = UUID()
		let title: String
		let image: UIImage?
		let weight: String
		let benefit: String
		let newPrice: String
		let oldPrice: String
	}
	
	struct FilterCard: Hashable {
		let title: String
	}
	
}

