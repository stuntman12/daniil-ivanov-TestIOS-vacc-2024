//
//  TitleSupplementaryView.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//
import UIKit

//TODO: - Переписать на SnapKit

final class TitleSupplementaryView: UICollectionReusableView {
	
	lazy var label: UILabel = settingLabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		settingView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension TitleSupplementaryView {
	func settingView() {
		settingLayout()
	}
	func settingLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		addSubview(label)
		return label
	}
	
	func settingLayout() {
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			label.topAnchor.constraint(equalTo: self.topAnchor)
		])
	}
}
