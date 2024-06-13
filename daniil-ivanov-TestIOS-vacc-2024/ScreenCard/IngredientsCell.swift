//
//  IngredientsCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//

import UIKit

final class IngredientsCell: UICollectionViewCell {
	private lazy var imageIngredient: UIImageView = settingImageView()
	private lazy var labelTitle: UILabel = settingLabelTitle()
	private lazy var labelWeight: UILabel = settingLabelWeight()
	private lazy var labelPrice: UILabel = settingLabelPrice()
	private lazy var labelCount: UILabel = settingLabelCount()
	private lazy var buttonMinus: UIButton = settingButtonMinus()
	private lazy var buttonPlus: UIButton = settingButtonPlus()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(element: IngredientsCardModel.IngredientsCell) {
		imageIngredient.image = UIImage(named: element.image)
		labelTitle.text = element.title
		labelWeight.text = element.weight + " гр"
		labelPrice.text = element.price
		labelCount.text = element.count
	}
}

private extension IngredientsCell {
	func settingMainView() {
		contentView.backgroundColor = .white
		contentView.layer.shadowRadius = 40
		contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
		contentView.layer.shadowColor = UIColor.black.cgColor
		settingLayout()
	}
	
	func settingImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		contentView.addSubview(imageView)
		return imageView
	}
	
	func settingLabelTitle() -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 12)
		contentView.addSubview(label)

		return label
	}
	
	func settingLabelWeight() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12)
		contentView.addSubview(label)
		return label
	}
	
	func settingLabelPrice() -> UILabel {
		let label = UILabel()
		label.textColor = .red
		label.font = UIFont.systemFont(ofSize: 16)
		contentView.addSubview(label)
		return label
	}
	
	func settingLabelCount() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		contentView.addSubview(label)
		return label
	}
	
	func settingButtonMinus() -> UIButton {
		let button = UIButton()
		button.setImage(
			UIImage(systemName: "minus"),
			for: .normal
		)
		button.tintColor = labelCount.text == "0" ? .black : .gray
		contentView.addSubview(button)
		return button
	}
	
	func settingButtonPlus() -> UIButton {
		let button = UIButton()
		button.setImage(
			UIImage(systemName: "plus"),
			for: .normal
		)
		button.tintColor = labelCount.text == "0" ? .gray : .black
		contentView.addSubview(button)
		return button
	}
	
	func settingLayout() {
		imageIngredient.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
			make.height.equalTo(65)
		}
		
		labelTitle.snp.makeConstraints { make in
			make.top.equalTo(imageIngredient.snp.bottom).offset(8)
			make.leading.equalToSuperview().offset(8)
			make.trailing.equalToSuperview().offset(-8)
		}
		
		labelWeight.snp.makeConstraints { make in
			make.top.equalTo(labelTitle.snp.bottom).offset(22)
			make.centerX.equalToSuperview()
		}
		
		labelPrice.snp.makeConstraints { make in
			make.top.equalTo(labelWeight.snp.bottom).offset(8)
			make.centerX.equalToSuperview()
		}
		
		labelCount.snp.makeConstraints { make in
			make.top.equalTo(labelPrice.snp.bottom).offset(16)
			make.centerX.equalToSuperview()
		}
		
		buttonMinus.snp.makeConstraints { make in
			make.trailing.equalTo(labelCount.snp.leading).offset(-10)
			make.height.width.equalTo(24)
			make.centerY.equalTo(labelCount.snp.centerY)
		}
		
		buttonPlus.snp.makeConstraints { make in
			make.leading.equalTo(labelCount.snp.trailing).offset(10)
			make.height.width.equalTo(24)
			make.centerY.equalTo(labelCount.snp.centerY)
		}
	}
}
