//
//  ViewController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
	
	var dataSource: UICollectionViewDiffableDataSource<CategoryModel.Section, CategoryModel.Card>?
	private lazy var collectionView: UICollectionView = settingCollectionView()
	
	
	private var arrayCardtwo: [CategoryModel.Card] = [
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		)
	]
	private var arrayCard: [CategoryModel.Card] = [
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		.init(
			title: "1",
			image: nil,
			weight: "1",
			benefit: "1",
			newPrice: "1",
			oldPrice: "1"
		),
		
		
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		settingMainView()
	}
}

// MARK: UICollectionViewDelegate<##>
extension CategoryViewController: UICollectionViewDelegate {
	
}

private extension CategoryViewController {
	private func settingMainView() {
		view.backgroundColor = UIColor(resource: .mainRed)
		settingDataSource()
		reloadData()
	}
}

// MARK: Setting CollectionView<##>
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
		collection.delegate = self
		view.addSubview(collection)
		collection.snp.makeConstraints {
			$0.top.equalToSuperview().offset(190)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
		return collection
	}
	
	func reloadData() {
		var snapshot = NSDiffableDataSourceSnapshot<CategoryModel.Section, CategoryModel.Card>()
		snapshot.appendSections([.filterCard, .card])
		snapshot.appendItems(
			arrayCard,
			toSection: .filterCard
		)
		
		snapshot.appendItems(
			arrayCardtwo,
			toSection: .card
		)
		
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
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
					return cell
				}
			}
		)
	}
	
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
	
	private func createLayoutCard() -> NSCollectionLayoutSection {
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			),
			elementKind: "Тонкое тесто",
			alignment: .topLeading
		)
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
		
		return section
	}
	
	private func createLayoutFilter() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .absolute(107),
				heightDimension: .fractionalHeight(0.3)
			)
		)
		
		item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
			leading: NSCollectionLayoutSpacing.fixed(16),
			top: nil,
			trailing: nil,
			bottom: nil
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.2)
			),
			subitems: [item]
		)
		
		group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(
			top: 24,
			leading: 10,
			bottom: 0,
			trailing: 0
		)
		section.orthogonalScrollingBehavior = .continuous
		
		return section
	}
}
