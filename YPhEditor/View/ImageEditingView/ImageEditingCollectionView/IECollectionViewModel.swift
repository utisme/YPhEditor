//
//  IECollectionViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit
import RxSwift

final class IECollectionViewModel: IECollectionViewModelProtocol {
    
    var superViewModel: ImageEditingViewModelProtocol?
    
    let disposeBag = DisposeBag()
    
    private var collectionView: UICollectionView!
    var currentCell: (UICollectionViewCell, Int) {
        guard let flowLayout = collectionView.collectionViewLayout as? IECollectionViewLayout,
              let currentItemIndex = flowLayout.currentItemIndex,
              let cell = collectionView.cellForItem(at: IndexPath(item: Int(currentItemIndex), section: 0))
        else { return (UICollectionViewCell(), 0) }      //TODO: handle error
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
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IEECollectionViewCell.id, for: indexPath) as? IEECollectionViewCell,
                  let correspondingEffect = ImageProcessingManager.Adjust.Effect(rawValue: cellIndex)?.getEffect(),
                  let effectIcon = correspondingEffect.apply(for: CurrentImageManager.shared.currentCIImage?.transformed(by: CGAffineTransform(scaleX: 0.1, y: 0.1)))
            else { return IEECollectionViewCell() }             //TODO: handle error
            
            cell.configure(withImage: UIImage(ciImage: effectIcon))
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
        collectionDidLoaded()
    }
    
    func configureForEffects() {
        collectionView.dataSource = effectsDataSource
        effectsDataSource.apply(effectsSnapshot)
        collectionDidLoaded()
    }
    
    func updateCollection() {
        collectionView.reloadData()
    }
    
    func collectionDidLoaded() {
        superViewModel?.collectionDidLoaded()
    }
    
    func cellChanged() {
        superViewModel?.cellChanged()
    }
    
    func prepareImageForEffectCell(_ image: CIImage, to view: MetalImageView) -> CIImage {
        ImageProcessingManager.Tools.fitImage(image, to: view, minScale: true)
    }
}
