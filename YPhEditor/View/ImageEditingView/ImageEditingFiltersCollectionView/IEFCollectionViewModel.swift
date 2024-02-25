//
//  IEFCollectionViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit

final class IEFCollectionViewModel: IEFCollectionViewModelProtocol {
       
    func getDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Int, Int> {
        
        UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IEFCollectionViewCell.id, for: indexPath)
                    as? IEFCollectionViewCell
            else { return IEFCollectionViewCell() }
            
            cell.configure(withValue: item)
            return cell
        }
    }
}
