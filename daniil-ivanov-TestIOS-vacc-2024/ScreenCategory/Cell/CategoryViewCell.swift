//
//  CategoryViewCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

//TODO: - Добавить огонек, разобраться с отступом от цен и кнопки
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
	private lazy var buttonAdd: UIButton = settingButtonAdd()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
		settingLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func point(
		inside point: CGPoint,
		with event: UIEvent?
	) -> Bool {
		return buttonAdd.bounds.contains(point)
	}
	
	func configure(
		image: String,
		title: String,
		weight: String,
		benefit: String,
		newPrice: String,
		oldPrice: String
	) {
		imageView.image = UIImage(named: image)
		labelTitle.text = title
		labelWeight.text = weight
		labelBenefit.text = benefit
		labelNewPrice.text = newPrice
		labelOldPrice.text = oldPrice
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
		imageView.contentMode = .scaleAspectFill
		contentView.addSubview(imageView)
		return imageView
	}
	
	func settingLabelTitle() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18)
		label.numberOfLines = 2
		contentView.addSubview(label)
		return label
	}
	
	func settingLabelWeight() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .gray
		label.setContentHuggingPriority(
			.defaultHigh,
			for: .horizontal
		)
		return label
	}
	
	func settingLabelBenefit() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor(resource: .benefit)
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
		return stackView
	}
	
	func settingLabelNewPrice() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		return label
	}
	
	func settingLabelOldPrice() -> UILabel {
		let label = UILabel()
		let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: label.text ?? "")
		attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
		label.attributedText = attributeString
		label.textColor = UIColor(resource: .oldPrice)
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
		stackView.alignment = .leading
		stackView.distribution = .fillProportionally
		contentView.addSubview(stackView)
		return stackView
	}
	
	func settingButtonAdd() -> UIButton {
		let button = UIButton()
		button.backgroundColor = UIColor(resource: .filter)
		button.setImage(UIImage(systemName: "plus"), for: .normal)
		button.tintColor = .systemRed
		button.layer.cornerRadius = 10
		contentView.addSubview(button)
		return button
	}
	
	func settingLayout() {
		
		imageView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(1)
			make.height.equalTo(121)
		}
		
		labelTitle.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(10)
			make.leading.equalTo(contentView.snp.leading).offset(8)
			make.trailing.equalTo(contentView.snp.trailing).offset(-8)
		}
		
		stackViewForWeightAndBenefit.snp.makeConstraints { make in
			make.top.equalTo(labelTitle.snp.bottom).offset(4)
			make.leading.equalTo(contentView.snp.leading).offset(8)
			make.trailing.equalTo(contentView.snp.trailing).offset(-8)
		}
		
		stackViewLabelNewPriceAndLabelOldPrice.snp.makeConstraints { make in
			make.top.equalTo(stackViewForWeightAndBenefit.snp.bottom)
			make.leading.equalTo(contentView.snp.leading).offset(8)
		}
		
		buttonAdd.snp.makeConstraints { make in
			make.width.height.equalTo(44)
			make.top.equalTo(stackViewForWeightAndBenefit.snp.bottom)
			make.trailing.equalTo(contentView.snp.trailing).offset(-9)
		}
	}
}
