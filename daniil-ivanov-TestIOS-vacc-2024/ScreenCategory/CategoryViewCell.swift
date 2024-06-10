//
//  CategoryViewCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

final class CategoryViewCell: UICollectionViewCell {
	
	private lazy var imageView: UIImageView = settingImageView()
	private lazy var labelTitle: UILabel = settingLabelTitle()
	private lazy var labelWeight: UILabel = settingLabelWeight()
	private lazy var labelBenefit: UILabel = settingLabelBenefit()
	private lazy var stackViewForWeightAndBenefit: UIStackView = settingStackViewForWeightAndBenefit()
	private lazy var labelNewPrice: UILabel = settingLabelNewPrice()
	private lazy var labelOldPrice: UILabel = settingLabelOldPrice()
	private lazy var stackViewLabelNewPriceAndLabelOldPrice: UIStackView = settingStackViewLabelNewPriceAndLabelOldPrice()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
		set()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension CategoryViewCell {
	func settingMainView() {
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 10
		contentView.clipsToBounds = true
	}
	
	func settingImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = UIImage(resource: .imagePizza)
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(imageView)
		return imageView
	}
	
	func settingLabelTitle() -> UILabel {
		let label = UILabel()
		label.text = "Филадельфия с лососем и базиликом"
		label.font = UIFont.systemFont(ofSize: 18)
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(label)
		return label
	}
	
	func settingLabelWeight() -> UILabel {
		let label = UILabel()
		label.text = "200г"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .gray
		label.setContentHuggingPriority(
			.defaultHigh,
			for: .horizontal
		)
		label.translatesAutoresizingMaskIntoConstraints = false
//		contentView.addSubview(label)
		return label
	}
	
	func settingLabelBenefit() -> UILabel {
		let label = UILabel()
		label.text = "Выгода 100Р!"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor(resource: .benefit)
		label.translatesAutoresizingMaskIntoConstraints = false
//		contentView.addSubview(label)
		return label
	}
	
	func settingStackViewForWeightAndBenefit() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [
			labelWeight,
			labelBenefit
		])
		stackView.axis = .horizontal
		stackView.alignment = .leading
		stackView.spacing = 10
		contentView.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}
	
	func settingLabelNewPrice() -> UILabel {
		let label = UILabel()
		label.text = "359"
		label.font = UIFont.systemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func settingLabelOldPrice() -> UILabel {
		let label = UILabel()
		label.text = "453"
		label.font = UIFont.systemFont(ofSize: 14)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func settingStackViewLabelNewPriceAndLabelOldPrice() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [
			labelNewPrice,
			labelOldPrice
		])
		stackView.axis = .vertical
		stackView.spacing = 4
		contentView.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}
	
	func set() {
		NSLayoutConstraint.activate(
			[
				imageView.topAnchor.constraint(
					equalTo: contentView.topAnchor
				),
				imageView.widthAnchor.constraint(
					equalTo: contentView.widthAnchor,
					multiplier: 1
				),
				
				imageView.heightAnchor.constraint(
					equalTo: contentView.heightAnchor,
					multiplier: 0.5
				),
				
				labelTitle.topAnchor.constraint(
					equalTo: imageView.bottomAnchor,
					constant: 10
				),
				
				labelTitle.leadingAnchor.constraint(
					equalTo: contentView.leadingAnchor,
					constant: 8
				),
				
				labelTitle.trailingAnchor.constraint(
					equalTo: contentView.trailingAnchor,
					constant: -8
				),
				
				stackViewForWeightAndBenefit.topAnchor.constraint(
					equalTo: labelTitle.bottomAnchor,
					constant: 8
				),
				
				stackViewForWeightAndBenefit.leadingAnchor.constraint(
					equalTo: contentView.leadingAnchor,
					constant: 8
				),
				
				stackViewForWeightAndBenefit.trailingAnchor.constraint(
					equalTo: contentView.trailingAnchor,
					constant: -8
				),
				
				stackViewLabelNewPriceAndLabelOldPrice.topAnchor.constraint(
					equalTo: stackViewForWeightAndBenefit.bottomAnchor,
					constant: 8
				),
				
				stackViewLabelNewPriceAndLabelOldPrice.leadingAnchor.constraint(
					equalTo: contentView.leadingAnchor,
					constant: 8
				),
			]
		)
	}
}
