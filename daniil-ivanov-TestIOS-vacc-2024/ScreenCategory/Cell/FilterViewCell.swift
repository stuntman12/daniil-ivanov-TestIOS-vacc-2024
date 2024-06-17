//
//  FilterViewCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
	lazy var labelFilter: UILabel = settingLabelFilter()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
		contentView.layer.cornerRadius = 10
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension FilterViewCell {
	func configure(text: String) {
		labelFilter.text = text
	}
}

private extension FilterViewCell {
	func settingMainView() {
		contentView.backgroundColor = UIColor(resource: .filter)
		settingLayout()
	}
	
	func settingLabelFilter() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		contentView.addSubview(label)
		return label
	}
	
	func settingLayout() {
		labelFilter.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Margins.mainHorizontal)
			make.trailing.equalToSuperview().offset(-Margins.mainHorizontal)
			make.centerY.equalToSuperview()
		}
	}
}
