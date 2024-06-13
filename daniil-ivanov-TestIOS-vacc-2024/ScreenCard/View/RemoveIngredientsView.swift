//
//  RemoveIngredientsView.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//

import UIKit

final class RemoveIngredientsView: UIView {
	
	enum Ingredients: String, CaseIterable {
		case onions = "Лук"
		case tomato = "Помидор"
		case cheese = "Сыр"
	}
	
	private lazy var stackViewIngresients: UIStackView = settingStackViewIngresients()
	private var toggle = false
	override init(frame: CGRect) {
		super.init(frame: frame)
		settimgMainView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func tupUp() {
		self.toggle = true
		print(toggle)
	}
}

private extension RemoveIngredientsView {
	func settimgMainView() {
		settingLayout()
	}
	
	func settingStackViewIngresients() -> UIStackView {
		let views: [UIView] = createSection()
		let stack = UIStackView(arrangedSubviews: views)
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 18
		self.addSubview(stack)
		return stack
	}
	
	func createSection() -> [UIView] {
		var views: [UIView] = []
		let allCases = Ingredients.allCases
		let allCountCase = Ingredients.allCases.count
		for i in 0...allCountCase - 1 {
			let item = allCases[i]
			let labelIngredient = settingLabelIngredient(text: item.rawValue)
			let viewCheckIngredient = settingViewCheckIngredient()
			let stack = createStackViewSection(views: [labelIngredient, viewCheckIngredient])
			views.append(stack)
			let view = createSeparator()
			views.append(view)
		}
		return views
	}
	
	func createStackViewSection(views: [UIView]) -> UIStackView {
		let stack = UIStackView(arrangedSubviews: views)
		stack.axis = .horizontal
		stack.spacing = 8
		return stack
	}
	
	func settingLabelIngredient(text: String) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.systemFont(ofSize: 14)
		return label
	}
	
	func settingViewCheckIngredient() -> UIImageView {
		let imageView = UIImageView()
		imageView.backgroundColor = toggle ? .green : .footerButton
		imageView.layer.cornerRadius = 2
		imageView.snp.makeConstraints { make in
			make.width.height.equalTo(20)
		}
		return imageView
	}
	
	func createSeparator() -> UIView {
		let view = UIView()
		view.applySeparatorLineHorizontalView()
		view.addGestureRecognizer(
			UIGestureRecognizer(
				target: self,
				action: #selector(tupUp)
			)
		)
		return view
	}
	
	func settingLayout() {
		stackViewIngresients.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalToSuperview()
		}
	}
}
