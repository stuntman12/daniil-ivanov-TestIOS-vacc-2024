//
//  UIView+.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 14.06.2024.
//

import UIKit

extension UIView {
	func applySeparatorLineVerticalView() {
		self.widthAnchor.constraint(equalToConstant: 1).isActive = true
		self.backgroundColor = UIColor(resource: .footerButton)
	}
	
	func applySeparatorLineHorizontalView() {
		self.heightAnchor.constraint(equalToConstant: 1).isActive = true
		self.backgroundColor = UIColor(resource: .footerButton)
	}
}
