//
//  TitleSupplementaryView.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 12.06.2024.
//
import UIKit
import SnapKit

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
		addSubview(label)
		return label
	}
	
	func settingLayout() {
		label.snp.makeConstraints { make in
			make.leading.top.equalToSuperview()
		}
	}
}
