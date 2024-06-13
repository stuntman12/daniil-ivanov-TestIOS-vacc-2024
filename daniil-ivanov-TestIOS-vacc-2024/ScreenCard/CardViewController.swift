//
//  CardViewController.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 10.06.2024.
//

import UIKit
import SnapKit

final class CardViewController: UIViewController {
	
	private let arrayImageForCarousel = [1,2,3]
	
	var mokData = MokData()
	var dataSource: UICollectionViewDiffableDataSource<IngredientsCardModel.Section, IngredientsCardModel.IngredientsCell>?
	private lazy var buttonBack: UIButton = settingButtonBack()
	private lazy var screenScroll: UIScrollView = settingScreenScroll()
	private lazy var contentView: UIView = settingContentView()
	private lazy var scrollViewForCarousel: UIScrollView = settingScrollViewForCarousel()
	private lazy var pageControl: UIPageControl = settingPageControll()
	private lazy var labelTitle: UILabel = settingLabelTitle()
	private lazy var labelDescription: UILabel = settingLabelDescription()
	private lazy var viewInfo = InfoPizzaView()
	private lazy var segmentControlSize: UISegmentedControl = settingSegmentControlSize()
	private lazy var segmentControlType: UISegmentedControl = settingSegmentControlType()
	private lazy var labelHeaderIngredients: UILabel = settingHeaderIngredients()
	private lazy var collectionViewIngredients: UICollectionView = settingCollectionView()
	private lazy var ButtonFooterCollectionView: UIButton = settingFooterButton()
	private lazy var labelHeaderRemoveIngredients: UILabel = settingLabelHeaderRemoveIngredients()
	private lazy var viewRemoveIngredients = RemoveIngredientsView()
	private lazy var buttonAdd: UIButton = settingButtonAdd()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		settingMainView()
	}
}

extension CardViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView == scrollViewForCarousel {
			pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
		}
	}
}

private extension CardViewController {
	func settingMainView() {
		view.backgroundColor = UIColor(resource: .main)
		settingLayout()
		settingDataSource()
		settingSnapshot()
		
		addImage(position: 0)
		addImage(position: 1)
		addImage(position: 2)
	}
	
	func settingButtonBack() -> UIButton {
		let button = UIButton()
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor(resource: .filter)
		button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
		button.tintColor = .black
		contentView.insertSubview(button, aboveSubview: scrollViewForCarousel)
		return button
	}
	
	func settingScreenScroll() -> UIScrollView {
		let scroll = UIScrollView()
		scroll.showsVerticalScrollIndicator = false
		view.addSubview(scroll)
		return scroll
	}
	
	func settingContentView() -> UIView {
		let view = UIView()
		screenScroll.addSubview(view)
		return view
	}
	
	
	func settingScrollViewForCarousel() -> UIScrollView {
		let scroll = UIScrollView()
		scroll.contentSize = CGSize(
			width: Int(UIScreen.main.bounds.width) * arrayImageForCarousel.count,
			height: 250
		)
		scroll.isPagingEnabled = true
		scroll.showsHorizontalScrollIndicator = false
		scroll.delegate = self
		contentView.addSubview(scroll)
		return scroll
	}
	
	func settingPageControll() -> UIPageControl {
		let control = UIPageControl()
		control.numberOfPages = 3
		control.pageIndicatorTintColor = .lightGray
		control.currentPageIndicatorTintColor = .red
		control.currentPage = 0
		contentView.addSubview(control)
		return control
	}
	
	func addImage(position: CGFloat) {
		let image = UIImageView()
		image.image = UIImage(resource: .pizzaForCard)
		image.contentMode = .scaleAspectFill
		scrollViewForCarousel.addSubview(image)
		let screenWidth = UIScreen.main.bounds.width
		image.frame = CGRect(
			x: Int(screenWidth * position),
			y: 0,
			width: Int(screenWidth),
			height: 250
		)
	}
	
	func settingLabelTitle() -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.text = "Римская пицца цыпленок с соусом песто с соусом песто"
		label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		contentView.addSubview(label)
		return label
	}
	
	func settingLabelDescription() -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.text = "Римское тесто, Курица, Помидоры черри, Сыр сливочный, Сыр Моцарелла, Соус песто, Салат руккола, Чеснок"
		label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
		contentView.addSubview(label)
		return label
	}
	
	func settingSegmentControlSize() -> UISegmentedControl {
		let segment = UISegmentedControl(items: ["Маленькая", "Средняя", "Большая"])
		segment.selectedSegmentIndex = 0
		contentView.addSubview(segment)
		return segment
	}
	
	func settingSegmentControlType() -> UISegmentedControl {
		let segment = UISegmentedControl(items: ["Традиционное тесто", "Тонкое тесто"])
		segment.selectedSegmentIndex = 0
		contentView.addSubview(segment)
		return segment
	}
	
	func settingHeaderIngredients() -> UILabel {
		let label = UILabel()
		label.text = "Добавить ингредиенты"
		contentView.addSubview(label)
		return label
	}
	
	func settingFooterButton() -> UIButton {
		let button = UIButton()
		button.setTitle(
			"Показать все",
			for: .normal
		)
		button.backgroundColor = UIColor(resource: .footerButton)
		button.setTitleColor(
			.red,
			for: .normal
		)
		contentView.addSubview(button)
		return button
	}
	
	func settingLabelHeaderRemoveIngredients() -> UILabel {
		let label = UILabel()
		label.text = "Убрать ингредиенты"
		contentView.addSubview(label)
		return label
	}
	
	func settingButtonAdd() -> UIButton {
		let button = UIButton()
		button.backgroundColor = .red
		button.setTitle("Добавить", for: .normal)
		button.layer.cornerRadius = 10
		contentView.addSubview(button)
		return button
	}
	
	func settingCollectionView() -> UICollectionView {
		let collection = UICollectionView(
			frame: .zero,
			collectionViewLayout: settingCollectionLayout()
		)
		collection.register(
			IngredientsCell.self,
			forCellWithReuseIdentifier: "\(IngredientsCell.self)"
		)
		collection.backgroundColor = UIColor(resource: .main)
		contentView.addSubview(collection)
		return collection
	}
	
	func settingDataSource() {
		dataSource = UICollectionViewDiffableDataSource<IngredientsCardModel.Section, IngredientsCardModel.IngredientsCell>(
			collectionView: collectionViewIngredients,
			cellProvider: {
				collectionView,
				indexPath,
				itemIdentifier in
				guard let section = IngredientsCardModel.Section(rawValue: indexPath.section) else { return nil}
				switch section {
				case .ingredients:
					let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: "\(IngredientsCell.self)",
						for: indexPath
					) as! IngredientsCell
					cell.configure(element: itemIdentifier)
					return cell
				}
			}
		)		
	}
	
	
	func settingSnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<
			IngredientsCardModel.Section,
			IngredientsCardModel.IngredientsCell
		>()
		
		snapshot.appendSections([.ingredients])
		snapshot.appendItems(
			mokData.arrayIngrediCell,
			toSection: .ingredients
		)
		
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
	func settingCollectionLayout() -> UICollectionViewLayout {
		let configure = UICollectionViewCompositionalLayoutConfiguration()
		
		configure.scrollDirection = .horizontal
		
		let layout = UICollectionViewCompositionalLayout(
			sectionProvider: { (sectionIndex, envirment) in
				return self.settingSectionLayout()
			},
			configuration: configure
		)
		return layout
	}
	
	func settingSectionLayout() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .estimated(109),
				heightDimension: .fractionalHeight(1)
			)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			), repeatingSubitem: item,
			count: 3
			
		)
		
		group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
		
		let section = NSCollectionLayoutSection(
			group: group
		)
		section.orthogonalScrollingBehavior = .groupPagingCentered

		return section
	}
	
	func settingLayout() {
		screenScroll.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { make in
			make.trailing.equalTo(screenScroll.snp.trailing)
			make.top.equalTo(screenScroll.snp.top)
			make.leading.equalTo(screenScroll.snp.leading)
			make.bottom.equalTo(screenScroll.snp.bottom)
			make.width.equalTo(screenScroll.snp.width)
		}
		
		buttonBack.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top).offset(10)
			make.height.width.equalTo(44)
			make.leading.equalTo(contentView.snp.leading).inset(16)
		}
		
		scrollViewForCarousel.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top)
			make.leading.equalTo(contentView.snp.leading)
			make.trailing.equalTo(contentView.snp.trailing)
			make.height.equalTo(254)
		}
		
		pageControl.snp.makeConstraints { make in
			make.top.equalTo(scrollViewForCarousel.snp.bottom).inset(20)
			make.centerX.equalTo(contentView.snp.centerX)
		}
		
		labelTitle.snp.makeConstraints { make in
			make.top.equalTo(scrollViewForCarousel.snp.bottom).offset(16)
			make.leading.equalTo(contentView.snp.leading).offset(16)
			make.trailing.equalTo(contentView.snp.trailing).offset(-16)
		}
		
		labelDescription.snp.makeConstraints { make in
			make.top.equalTo(labelTitle.snp.bottom).offset(16)
			make.leading.equalTo(contentView).offset(16)
			make.trailing.equalTo(contentView).offset(-16)
		}
		
		contentView.addSubview(viewInfo)
		
		viewInfo.snp.makeConstraints { make in
			make.top.equalTo(labelDescription.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}
		
		segmentControlSize.snp.makeConstraints { make in
			make.top.equalTo(viewInfo.snp.bottom).offset(16)
			make.height.equalTo(42)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}
		
		segmentControlType.snp.makeConstraints { make in
			make.top.equalTo(segmentControlSize.snp.bottom).offset(16)
			make.height.equalTo(42)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}
		
		labelHeaderIngredients.snp.makeConstraints { make in
			make.top.equalTo(segmentControlType.snp.bottom).offset(24)
			make.leading.equalTo(segmentControlType.snp.leading)
		}
		
		collectionViewIngredients.snp.makeConstraints { make in
			make.top.equalTo(labelHeaderIngredients.snp.bottom).offset(16)
			make.height.equalTo(205)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}
		
		ButtonFooterCollectionView.snp.makeConstraints { make in
			make.top.equalTo(collectionViewIngredients.snp.bottom).offset(16)
			make.leading.trailing.equalTo(collectionViewIngredients)
			make.height.equalTo(44)
		}
		
		contentView.addSubview(viewRemoveIngredients)
		
		labelHeaderRemoveIngredients.snp.makeConstraints { make in
			make.top.equalTo(ButtonFooterCollectionView.snp.bottom).offset(24)
			make.leading.equalTo(segmentControlType.snp.leading)
		}
		
		viewRemoveIngredients.snp.makeConstraints { make in
			make.top.equalTo(labelHeaderRemoveIngredients.snp.bottom).offset(24)
			make.width.equalTo(collectionViewIngredients)
			make.centerX.equalTo(contentView.snp.centerX)
		}
		
		buttonAdd.snp.makeConstraints { make in
			make.top.equalTo(viewRemoveIngredients.snp.bottom).offset(24)
			make.centerX.equalTo(contentView.snp.centerX)
			make.width.equalTo(viewRemoveIngredients)
			make.height.equalTo(44)
			make.bottom.equalTo(contentView.snp.bottom)
		}
	}
}
