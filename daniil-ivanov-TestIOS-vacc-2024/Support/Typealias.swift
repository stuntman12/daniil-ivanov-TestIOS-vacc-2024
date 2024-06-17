//
//  typealias.swift
//  daniil-ivanov-TestIOS-vacc-2024
//
//  Created by Даниил Иванов on 15.06.2024.
//

import UIKit

typealias EmptyClosure = () -> Void
typealias СollectionDataSource = UICollectionViewDiffableDataSource<CategoryModel.Section, CategoryModel.Card>
typealias СollectionSnapShot = NSDiffableDataSourceSnapshot<CategoryModel.Section, CategoryModel.Card>
typealias CollectionDataSource = UICollectionViewDiffableDataSource<CardModel.Section, CardModel.IngredientsCell>
typealias CollectionSnapShot = NSDiffableDataSourceSnapshot<CardModel.Section, CardModel.IngredientsCell>
