//
//  FilterViewCell.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
	private lazy var labelFilter: UILabel = settingLabelFilter()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingMainView()
		contentView.layer.cornerRadius = 10
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension FilterViewCell {
	func settingMainView() {
		contentView.backgroundColor = UIColor(resource: .filter)
		
	}
	
	func settingLabelFilter() -> UILabel {
		let label = UILabel()
		return label 
	}
}
