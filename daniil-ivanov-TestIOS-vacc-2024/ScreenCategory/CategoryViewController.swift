//
//  CategoryViewController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

protocol ICategoryViewController: AnyObject {
	func viewReady(model: [CategoryModel.Card], filter: [CategoryModel.Card])
}

class CategoryViewController: UIViewController {
	
	// MARK: Variables
	private var modelAutor = [CategoryModel.Card]()
	private var modelSlim = [CategoryModel.Card]()
	private var modelFilter = [CategoryModel.Card]()
	var dataSource: СollectionDataSource?
	private lazy var collectionView: UICollectionView = settingCollectionView()
	private lazy var imageViewHeaderPizza: UIImageView = settingImageViewHeaderPizza()
	private lazy var titleHeader: UILabel = settingTitleHeader()
	private lazy var buttonBack: UIButton = settingButtonBack()
	
	var presenter: ICategoryPresenter?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		settingMainView()
		presenter?.loadData()
	}
	
	@objc func tupAddButton() {
		presenter?.tupButtonAdd()
	}
}

extension CategoryViewController: ICategoryViewController {
	func viewReady(model: [CategoryModel.Card], filter: [CategoryModel.Card]) {
		modelFilter = filter
		model.forEach { item in
			switch item.type {
			case .slim:
				modelSlim.append(item)
			case .autor:
				modelAutor.append(item)
			}
		}
		reloadData()
	}
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
		view.addSubview(collection)
		return collection
	}
	
	
	
	
	// MARK: Setting Layout
	func settingLayout() {
		
		imageViewHeaderPizza.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(70)
			make.trailing.equalToSuperview()
		}
		
		buttonBack.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(70)
			make.height.width.equalTo(44)
			make.leading.equalToSuperview().inset(Margins.mainHorizontal)
		}
		
		titleHeader.snp.makeConstraints { make in
			make.top.equalTo(buttonBack.snp.bottom).offset(24)
			make.leading.equalToSuperview().offset(Margins.mainHorizontal)
		}
		
		collectionView.snp.makeConstraints {
			$0.top.equalToSuperview().offset(200)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}
}

// MARK: Setting CollectionView
private extension CategoryViewController {
	
	// MARK: DataSourceSnapshot
	func reloadData() {
		var snapshot = СollectionSnapShot()
		
		snapshot.appendSections([.filterCards, .autor, .slim])
		snapshot.appendItems(
			modelFilter,
			toSection: .filterCards
		)
		
		snapshot.appendItems(
			modelSlim,
			toSection: .slim
		)
		
		snapshot.appendItems(
			modelAutor,
			toSection: .autor
		)
		
		
		
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
	// MARK: DiffableDataSource
	
	func settingDataSource() {
		dataSource = СollectionDataSource(
			collectionView: collectionView,
			cellProvider: {
				collectionView,
				indexPath,
				itemIdentifier in
				
				let section = CategoryModel.Section.allCases[indexPath.section]
				switch section {
				case .filterCards:
					let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(FilterViewCell.self)",
						for: indexPath
					) as! FilterViewCell
					cell.configure(text: itemIdentifier.type.type)
					return cell
				case .slim,
						.autor:
					let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(CategoryViewCell.self)",
						for: indexPath
					) as! CategoryViewCell
					cell.addTargetButton(
						target: self,
						action: #selector(self.tupAddButton),
						event: .touchUpInside
					)
					cell.configure(
						image: itemIdentifier.image,
						title: itemIdentifier.name,
						weight: itemIdentifier.weight,
						benefit: itemIdentifier.benefit,
						newPrice: itemIdentifier.price,
						oldPrice: itemIdentifier.oldPrice
					)
					return cell
				}
			}
		)
		settingSupplementaryView()
	}
	
	// MARK: SupplementaryView
	func settingSupplementaryView() {
		let supplementaryRegistrationSlim = UICollectionView.SupplementaryRegistration
		<TitleSupplementaryView>( elementKind: "Slim") { [weak self]
			supplementaryView,
			elementKind,
			indexPath in
			supplementaryView.label.text = self?.dataSource?.snapshot().itemIdentifiers[indexPath.section].type.type
			supplementaryView.label.font = UIFont.systemFont(
				ofSize: 20,
				weight: .bold
			)
		}
		let supplementaryRegistrationAutor = UICollectionView.SupplementaryRegistration
		<TitleSupplementaryView>(elementKind: "Autor") {[weak self]
			supplementaryView,
			string,
			indexPath in
			supplementaryView.label.text = self?.dataSource?.snapshot().itemIdentifiers[indexPath.section].type.type
			supplementaryView.label.font = UIFont.systemFont(
				ofSize: 20,
				weight: .bold
			)
		}
		
		dataSource?.supplementaryViewProvider = { (view, kind, index) in
			return view.dequeueConfiguredReusableSupplementary(
				using: kind == "Autor" ? supplementaryRegistrationAutor : supplementaryRegistrationSlim,
				for: index
			)
		}
	}
	
	// MARK: CollectionViewLayout
	func settingCollectionLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [unowned self]
			(sectionIndex, envirment) -> NSCollectionLayoutSection in
			let section = CategoryModel.Section.allCases[sectionIndex]
			switch section {
			case .filterCards:
				return createLayoutFilter()
			case .autor, .slim:
				return createLayoutCard()
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
			bottom: 20,
			trailing: 8
		)
		
		section.interGroupSpacing = 10
		
		let sectionAutor = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(44)
			),
			elementKind: "Slim",
			alignment: .top
		)
		
		let sectionSlim = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(44)
			),
			elementKind: "Autor",
			alignment: .top
		)
		
		section.boundarySupplementaryItems = [sectionAutor, sectionSlim]
		
		return section
	}
	
	// MARK: LayoutFilter
	private func createLayoutFilter() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .estimated(107),
				heightDimension: .estimated(40)
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


