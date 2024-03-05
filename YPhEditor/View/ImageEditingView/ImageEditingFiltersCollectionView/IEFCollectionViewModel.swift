//
//  IEFCollectionViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit
import RxSwift

final class IEFCollectionViewModel: IEFCollectionViewModelProtocol {
    
    var superViewModel: ImageEditingViewModelProtocol?
    
    let disposeBag = DisposeBag()
    
    private var collectionView: UICollectionView!
    var currentCell: (IEFCollectionViewCell, Int) {
        guard let flowLayout = collectionView.collectionViewLayout as? IEFCollectionViewLayout,
              let currentItemIndex = flowLayout.currentItemIndex,
              let cell = collectionView.cellForItem(at: IndexPath(item: Int(currentItemIndex), section: 0)) as? IEFCollectionViewCell
        else { return (IEFCollectionViewCell(), 0) }      //TODO: handle error
        return (cell, Int(currentItemIndex))
    }
    
    private var filtersDataSource: UICollectionViewDiffableDataSource<Int, Int>!
    private var effectsDataSource: UICollectionViewDiffableDataSource<Int, Int>!
    private var filtersSnapshot: NSDiffableDataSourceSnapshot<Int, Int>!
    private var effectsSnapshot: NSDiffableDataSourceSnapshot<Int, Int>!
    
    func prepareData(for collectionView: UICollectionView) {
        //TODO: заменить cellIndex на экземпляр фильтра
        filtersDataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, cellIndex in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IEFCollectionViewCell.id, for: indexPath) as? IEFCollectionViewCell
            else { return IEFCollectionViewCell() }
            
            let correspondingFilter = ImageProcessingManager.shared.filtersStack[cellIndex]
            let filterIcon = correspondingFilter.filterIcon
            cell.configure(withValue: correspondingFilter.value, image: filterIcon)
            return cell
        }
        
        filtersSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        filtersSnapshot.appendSections([0])
        filtersSnapshot.appendItems(ImageProcessingManager.Adjust.Filter.allCases.map({ effect in
            effect.rawValue
        }))
        
        effectsDataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, cellIndex in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IEFCollectionViewCell.id, for: indexPath) as? IEFCollectionViewCell
            else { return IEFCollectionViewCell() }
            
            let correspondingEffect = ImageProcessingManager.shared.effectsStack[cellIndex]
            let effectIcon = correspondingEffect.effectIcon
            cell.configure(withValue: 0, image: effectIcon)
            return cell
        }
        
        effectsSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        effectsSnapshot.appendSections([0])
        effectsSnapshot.appendItems(ImageProcessingManager.Adjust.Effect.allCases.map({ effect in
            effect.rawValue
        }))
        
        self.collectionView = collectionView
        configureForFilters()
    }
    
    func configureForFilters() {
        collectionView.dataSource = filtersDataSource
        filtersDataSource.apply(filtersSnapshot)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
        collectionView.reloadData()
        collectionDidLoaded()
    }
    
    func configureForEffects() {
        collectionView.dataSource = effectsDataSource
        effectsDataSource.apply(effectsSnapshot)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
        collectionView.reloadData()                                                                                             //TODO: костыль
        collectionDidLoaded()
    }
    
    func collectionDidLoaded() {
        superViewModel?.collectionDidLoaded()
    }
    
    func cellChanged() {
        superViewModel?.cellChanged()
    }
}
