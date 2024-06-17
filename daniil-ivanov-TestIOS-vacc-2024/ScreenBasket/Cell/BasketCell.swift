//
//  BasketCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 14.06.2024.
//

import UIKit

final class BasketCell: UICollectionViewCell {
	
	private lazy var imageViewProduct: UIImageView = settingImageViewProduct()
	private lazy var stackView: UIStackView = settingStackView()
	private lazy var labelTitleProduct: UILabel = settingLabelTitleProduct()
	private lazy var buttonDelete: UIButton = settingButtonDelete()
	private lazy var viewСontainer: UIView = settingViewContainer()
	private lazy var labelPrice: UILabel = settingLabelPrice()
	private lazy var labelCount: UILabel = settingLabelCount()
	private lazy var buttonMinus: UIButton = settingButtonMinus()
	private lazy var buttonPlus: UIButton = settingButtonPlus()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(image: String, title: String, count: String, price: String) {
		imageViewProduct.image = UIImage(named: image)
		labelTitleProduct.text = title
		labelCount.text = count
		labelPrice.text = price + "₽"
		buttonMinus.tintColor = labelCount.text == "0" ? .gray : .black
		buttonPlus.tintColor = labelCount.text == "0" ? .gray : .black
	}
}

private extension BasketCell {
	func settingView() {
		settingLayout()
	}
	
	func settingLayout() {
		imageViewProduct.snp.makeConstraints { make in
			make.top.leading.bottom.equalToSuperview()
			make.width.equalTo(118)
			make.height.equalTo(84)
			make.bottom.equalToSuperview().offset(-8)
		}
		
		stackView.snp.makeConstraints { make in
			make.leading.equalTo(imageViewProduct.snp.trailing).offset(8)
			make.top.trailing.equalToSuperview()
		}
		
		viewСontainer.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(8)
			make.leading.equalTo(imageViewProduct.snp.trailing).offset(8)
			make.height.equalTo(44)
			make.width.equalTo(95)
			make.bottom.equalToSuperview().offset(-12)
		}
		
		buttonMinus.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(8)
			make.centerY.equalToSuperview()
			make.height.equalTo(24)
			make.width.equalTo(24)
		}
		
		labelCount.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		buttonPlus.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-8)
			make.centerY.equalToSuperview()
			make.height.equalTo(24)
			make.width.equalTo(24)
		}
		
		labelPrice.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(36)
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview().offset(-4)
		}
	}
	
	func settingImageViewProduct() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 8
		contentView.addSubview(image)
		return image
	}
	
	func settingStackView() -> UIStackView {
		let stack = UIStackView(arrangedSubviews: [
			labelTitleProduct,
			buttonDelete
		])
		stack.axis = .horizontal
		stack.distribution = .equalCentering
		stack.alignment = .top
		stack.spacing = 8
		contentView.addSubview(stack)
		return stack
	}
	
	func settingLabelTitleProduct() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.setContentCompressionResistancePriority(
			.defaultLow,
			for: .horizontal
		)
		return label
	}
	
	func settingButtonDelete() -> UIButton {
		let button = UIButton()
		button.tintColor = .lightGray
		button.setImage(
			UIImage(systemName: "multiply"),
			for: .normal
		)
		return button
	}
	
	func settingLabelPrice() -> UILabel {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		contentView.addSubview(label)
		return label
	}
	
	func settingViewContainer() -> UIView {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.backgroundColor = .footerButton
		contentView.addSubview(view)
		return view
	}
	
	func settingLabelCount() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		viewСontainer.addSubview(label)
		return label
	}
	
	func settingButtonMinus() -> UIButton {
		let button = UIButton()
		button.setImage(
			UIImage(systemName: "minus"),
			for: .normal
		)
		viewСontainer.addSubview(button)
		return button
	}
	
	func settingButtonPlus() -> UIButton {
		let button = UIButton()
		button.setImage(
			UIImage(systemName: "plus"),
			for: .normal
		)
		viewСontainer.addSubview(button)
		return button
	}
}
