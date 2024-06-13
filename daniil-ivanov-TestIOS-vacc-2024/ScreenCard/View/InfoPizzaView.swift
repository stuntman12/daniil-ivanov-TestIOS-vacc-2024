//
//  InfoPizzaView.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//

import UIKit
import SnapKit

final class InfoPizzaView: UIView {
	
	enum InfoPizza: String, CaseIterable {
		case calorie = "ккал"
		case protein = "белок"
		case fats = "жиры"
		case carbohydrates = "углеводы"
	}
	
	private lazy var stackViewAll: UIStackView = settingStackViewAll()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension InfoPizzaView {
	func settingMainView() {
		settingLayout()
	}
	
	func createSection() -> [UIView] {
		var views: [UIView] = []
		let allSection = InfoPizza.allCases.count
		let allCase = InfoPizza.allCases
		for i in 0...allSection - 1 {
			let item = allCase[i]
			let viewNumber = settingLabelNumber(count: "100")
			let viewName = settingLabelName(item: item.rawValue)
			let stack = settingStackViewSection(views: [viewNumber, viewName])
			views.append(stack)
			let view = settingSeparator()
			views.append(view)
		}
		return views
	}
	
	func settingStackViewAll() -> UIStackView {
		let views: [UIView] = createSection()
		let stack = UIStackView(arrangedSubviews: views)
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.alignment = .center
		stack.layer.borderWidth = 0.2
		stack.layer.cornerRadius = 10
		stack.layer.borderColor = UIColor.lightGray.cgColor
		self.addSubview(stack)
		return stack
	}

	func settingStackViewSection(views: [UIView]) -> UIStackView {
		let stack = UIStackView(arrangedSubviews: views)
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		return stack
	}
	
	func settingLabelNumber(count: String) -> UILabel {
		let label = UILabel()
		label.text = count
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		return label
	}	
	
	func settingLabelName(item: String) -> UILabel {
		let label = UILabel()
		label.text = item
		label.setContentHuggingPriority(
			.defaultHigh,
			for: .horizontal
		)
		label.setContentCompressionResistancePriority(
			.defaultLow,
			for: .horizontal
		)
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 12, weight: .light)
		return label
	}
	
	func settingSeparator() -> UIView {
		let view = UIView()
		view.applySeparatorLineVerticalView()
		return view
	}
	
	func settingLayout() {
		stackViewAll.snp.makeConstraints { make in
			make.top.leading.bottom.trailing.equalToSuperview()
		}
	}
}

extension UIView {
	func applySeparatorLineVerticalView(width: CGFloat = 0.2) {
		self.widthAnchor.constraint(equalToConstant: width).isActive = true
		self.heightAnchor.constraint(equalToConstant: 40).isActive = true
		self.backgroundColor = UIColor(resource: .footerButton)
	}
	
	func applySeparatorLineHorizontalView() {
		self.heightAnchor.constraint(equalToConstant: 1).isActive = true
		self.backgroundColor = UIColor(resource: .footerButton)
	}
}
