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
    
    let disposeBag = DisposeBag()
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
       
    private func getDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Int, Int> {
        
        UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IEFCollectionViewCell.id, for: indexPath)
                    as? IEFCollectionViewCell
            else { return IEFCollectionViewCell() }
            
            cell.configure(withImage: Resources.Images.ImageEditing.Filters.exposure)
            return cell
        }
    }
    
    func setupDataSource(for collectionView: UICollectionView) {
        
        dataSource = getDataSource(for: collectionView)
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(ImageProcessingManager.Filter.allCases.map({ filter in
            filter.rawValue
        }))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setCurrentFilter(as rawValue: Int) {
        
        ImageProcessingManager.shared.setFilter(with: rawValue)
    }
    
    func setCellConfigurations(for cell: IEFCollectionViewCell) {
        
        ImageProcessingManager.shared.currentFilter?.valueObservable?
            .asObservable()
            .subscribe { value in
                cell.configure(withValue: value)
            }
            .disposed(by: disposeBag)
    }
}
