//
//  BasketVewController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

final class BasketVewController: UIViewController {
	
	private lazy var viewUpContainer: UIView = settingUpView()
	private lazy var buttonDelete: UIButton = settingButtomDelete()
	private lazy var buttonBack: UIButton = settingButtonBack()
	private lazy var collectionViewBasket: UICollectionView = settingCollectionViewBasket()
	private lazy var viewBottomContainer: UIView = settingBottomView()
	private lazy var labelBottom: UILabel = settingLabelBottom()
	private lazy var labelPriceBottom: UILabel = settingLabelPriceBottom()
	private lazy var buttonOrder: UIButton = settingButtonOrder()
	
	private var dataSource: UICollectionViewDiffableDataSource<BasketModel.Section, BasketModel.Product>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		settingMainView()
	}
}

// MARK: Setting Views
private extension BasketVewController {
	func settingMainView() {
		view.backgroundColor = .white
		settingLayoutView()
		createDataSource()
		createSnapShot()
	}
	
	func settingUpView() -> UIView {
		let upView = UIView()
		view.addSubview(upView)
		return upView
	}
	
	func settingButtomDelete() -> UIButton {
		let button = UIButton()
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor(resource: .filter)
		button.setImage(UIImage(resource: .iconbasket), for: .normal)
		button.tintColor = .black
		viewUpContainer.addSubview(button)
		return button
	}
	
	func settingButtonBack() -> UIButton {
		let button = UIButton()
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor(resource: .filter)
		button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
		button.tintColor = .black
		viewUpContainer.addSubview(button)
		return button
	}
	
	func settingCollectionViewBasket() -> UICollectionView {
		let collection = UICollectionView(
			frame: .zero,
			collectionViewLayout: createCollectionLayout()
		)
		collection.register(
			BasketCell.self,
			forCellWithReuseIdentifier: "\(BasketCell.self)"
		)
		view.addSubview(collection)
		return collection
	}
	
	func settingBottomView() -> UIView {
		let bottomView = UIView()
		view.addSubview(bottomView)
		return bottomView
	}
	
	func settingLabelBottom() -> UILabel {
		let label = UILabel()
		label.text = "Сумма заказа"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .oldPrice
		viewBottomContainer.addSubview(label)
		return label
	}
	
	func settingLabelPriceBottom() -> UILabel {
		let label = UILabel()
		label.text = "2 543₽"
		label.font = UIFont.systemFont(ofSize: 26)
		label.textColor = .black
		viewBottomContainer.addSubview(label)
		return label
	}
	
	func settingButtonOrder() -> UIButton {
		let button = UIButton()
		button.backgroundColor = .red
		button.setTitle(
			"Оформить заказ",
			for: .normal
		)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.layer.cornerRadius = 10
		viewBottomContainer.addSubview(button)
		return button
	}
	
	func settingLayoutView() {
		viewUpContainer.snp.makeConstraints { make in
			make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
			make.height.equalTo(64)
		}
		
		buttonDelete.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.height.width.equalTo(44)
			make.trailing.equalToSuperview().offset(-Margins.mainHorizontal)
		}
		
		buttonBack.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.height.width.equalTo(44)
			make.leading.equalToSuperview().offset(Margins.mainHorizontal)
		}
		
		collectionViewBasket.snp.makeConstraints { make in
			make.top.equalTo(viewUpContainer.snp.bottom)
			make.bottom.equalTo(viewBottomContainer.snp.top)
			make.leading.equalTo(Margins.mainHorizontal)
			make.trailing.equalTo(-Margins.mainHorizontal)
		}
		
		viewBottomContainer.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(100)
		}
		
		labelBottom.snp.makeConstraints { make in
			make.top.leading.equalTo(viewBottomContainer).offset(16)
		}
		
		labelPriceBottom.snp.makeConstraints { make in
			make.top.equalTo(labelBottom.snp.bottom).offset(4)
			make.leading.equalToSuperview().offset(Margins.mainHorizontal)
		}
		
		buttonOrder.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(18)
			make.trailing.equalToSuperview().offset(-Margins.mainHorizontal)
			make.width.equalTo(144)
			make.height.equalTo(44)
		}
	}
}

// MARK: Setting DataSource and Layout collection
private extension BasketVewController {
	func createDataSource() {
		dataSource = UICollectionViewDiffableDataSource<BasketModel.Section, BasketModel.Product>(
			collectionView: collectionViewBasket,
			cellProvider: {
				collectionView,
				indexPath,
				itemIdentifier in
				guard let section = BasketModel.Section(rawValue: indexPath.section) else {
					return nil
				}
				switch section {
				case .product:
					let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(BasketCell.self)",
						for: indexPath
					) as! BasketCell
					cell.configure(
						image: itemIdentifier.image,
						title: itemIdentifier.title,
						count: itemIdentifier.count,
						price: itemIdentifier.price
					)
					return cell
				}
			}
		)
	}
	
	func createSnapShot() {
		var snapshot = NSDiffableDataSourceSnapshot<BasketModel.Section, BasketModel.Product>()
		snapshot.appendSections([.product])
		let array = MokData().arrayBasketProduct
		snapshot.appendItems(array, toSection: .product)
		
		dataSource.apply(snapshot, animatingDifferences: true)
	}
	
	func createCollectionLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { index, envirment in
			return self.createSectionLayout()
		}
		return layout
	}
	
	func createSectionLayout() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			)
		)
		let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(92)
		),
			subitems: [item]
		)
		let section = NSCollectionLayoutSection(
			group: group
		)
		section.interGroupSpacing = 8
		section.contentInsets = NSDirectionalEdgeInsets(
			top: 24,
			leading: 0,
			bottom: 0,
			trailing: 0
		)
		return section
	}
}

