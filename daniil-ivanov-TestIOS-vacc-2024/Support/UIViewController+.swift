//
//  UIViewController+.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import Foundation
import SwiftUI

extension UIViewController {
	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController
		
		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}
		
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}
	
	func preview() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}
