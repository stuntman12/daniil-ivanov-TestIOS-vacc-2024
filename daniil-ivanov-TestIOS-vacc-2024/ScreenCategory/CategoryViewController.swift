//
//  ViewController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
	
	// MARK: Variables
	var mokData = MokData()
	var dataSource: UICollectionViewDiffableDataSource<CategoryModel.Section, CategoryModel.Card>?
	private lazy var collectionView: UICollectionView = settingCollectionView()
	private lazy var imageViewHeaderPizza: UIImageView = settingImageViewHeaderPizza()
	private lazy var titleHeader: UILabel = settingTitleHeader()
	private lazy var buttonBack: UIButton = settingButtonBack()
	override func viewDidLoad() {
		super.viewDidLoad()
		settingMainView()
	}
}

// MARK: UICollectionViewDelegate
extension CategoryViewController: UICollectionViewDelegate {
	
}

// MARK: Setting View
private extension CategoryViewController {
	private func settingMainView() {
		view.backgroundColor = UIColor(resource: .mainRed)
		settingDataSource()
		settingLayout()
		reloadData()
	}
	
	// MARK: SettingImageViewHeaderPizza
	func settingImageViewHeaderPizza() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = UIImage(resource: .pizzaHeader)
		imageView.contentMode = .scaleAspectFill
		view.insertSubview(imageView, belowSubview: collectionView)
		return imageView
	}
	
	func settingButtonBack() -> UIButton {
		let button = UIButton()
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor(resource: .filter)
		button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
		button.tintColor = .black
		view.insertSubview(button, belowSubview: collectionView)
		return button
	}
	
	func settingTitleHeader() -> UILabel {
		let label = UILabel()
		label.font = UIFont.systemFont(
			ofSize: 26,
			weight: .bold
		)
		label.text = "Пицца"
		label.textColor = .white
		view.insertSubview(label, belowSubview: collectionView)
		return label
	}
	
	// MARK: Setting Layout
	func settingLayout() {
		
		imageViewHeaderPizza.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(70)
			make.trailing.equalToSuperview()
		}
		
		collectionView.snp.makeConstraints {
			$0.top.equalToSuperview().offset(200)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
		
		buttonBack.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(70)
			make.height.width.equalTo(44)
			make.leading.equalToSuperview().inset(16)
		}
		
		titleHeader.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.top.equalTo(buttonBack.snp.bottom).offset(24)
		}
		
	}
}

// MARK: Setting CollectionView
private extension CategoryViewController {
	func settingCollectionView() -> UICollectionView {
		let collection = UICollectionView(
			frame: .zero,
			collectionViewLayout: settingCollectionLayout()
		)
		collection.backgroundColor = UIColor(resource: .main)
		collection.register(
			FilterViewCell.self,
			forCellWithReuseIdentifier: "\(FilterViewCell.self)"
		)
		collection.register(
			CategoryViewCell.self,
			forCellWithReuseIdentifier: "\(CategoryViewCell.self)"
		)
		collection.showsVerticalScrollIndicator = false 
		collection.delegate = self
		view.addSubview(collection)
		return collection
	}
	
	// MARK: DataSourceSnapshot
	func reloadData() {
		var snapshot = NSDiffableDataSourceSnapshot<CategoryModel.Section, CategoryModel.Card>()
		snapshot.appendSections([.filterCard, .card])
		snapshot.appendItems(
			mokData.arrayCard,
			toSection: .filterCard
		)
		
		snapshot.appendItems(
			mokData.arrayCardtwo,
			toSection: .card
		)
		
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
	// MARK: DiffableDataSource
	func settingDataSource() {
		dataSource = UICollectionViewDiffableDataSource<CategoryModel.Section, CategoryModel.Card>(
			collectionView: collectionView,
			cellProvider: {
				collectionView,
				indexPath,
				itemIdentifier in
				guard let section = CategoryModel.Section(rawValue: indexPath.section) else {
					return nil }
				switch section {
				case .card:
					guard let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(CategoryViewCell.self)",
						for: indexPath
					) as? CategoryViewCell else { return UICollectionViewCell() }
					return cell
				case .filterCard:
					guard let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(FilterViewCell.self)",
						for: indexPath
					) as? FilterViewCell else { return UICollectionViewCell() }
					cell.layer.cornerRadius = 10
					cell.configure(text: itemIdentifier.title)
					return cell
				}
			}
		)
		settingSupplementaryView()
	}
	
	// MARK: SupplementaryView
	func settingSupplementaryView() {
		let supplementaryRegistration = UICollectionView.SupplementaryRegistration
		<TitleSupplementaryView>(elementKind: "HeaderCard") {
			(supplementaryView, string, indexPath) in
			supplementaryView.label.text = "Тонкое тесто"
			supplementaryView.label.font = UIFont.systemFont(
				ofSize: 20,
				weight: .bold
			)
			
		}
		dataSource?.supplementaryViewProvider = { (view, kind, index) in
			return self.collectionView.dequeueConfiguredReusableSupplementary(
				using: supplementaryRegistration,
				for: index
			)
		}
	}
	
	// MARK: CollectionViewLayout
	func settingCollectionLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [unowned self]
			(sectionIndex, envirment)  -> NSCollectionLayoutSection in
			guard let section = CategoryModel.Section(rawValue: sectionIndex) else {
				fatalError("Unknown section kind")
			}
			switch section {
			case .card:
				return createLayoutCard()
			case .filterCard:
				return createLayoutFilter()
			}
		}
		return layout
	}
	
	// MARK: LayoutCard
	private func createLayoutCard() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(0.5),
				heightDimension: .fractionalHeight(1)
			)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.4)
			),
			repeatingSubitem: item,
			count: 2
		)
		
		group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
		
		let section = NSCollectionLayoutSection(group: group)
		
		section.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: 8,
			bottom: 0,
			trailing: 8
		)
		
		section.interGroupSpacing = 10
		
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(44)
			),
			elementKind: "HeaderCard",
			alignment: .top
		)
		section.boundarySupplementaryItems = [sectionHeader]
		
		return section
	}
	
	// MARK: LayoutFilter
	private func createLayoutFilter() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .absolute(107),
				heightDimension: .fractionalHeight(0.5)
			)
		)
		
		item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
			leading: NSCollectionLayoutSpacing.fixed(8),
			top: nil,
			trailing: nil,
			bottom: nil
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.1)
			),
			subitems: [item]
		)
		
		group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(
			top: 24,
			leading: 8,
			bottom: 0,
			trailing: 0
		)
		section.orthogonalScrollingBehavior = .continuous
		
		return section
	}
}
