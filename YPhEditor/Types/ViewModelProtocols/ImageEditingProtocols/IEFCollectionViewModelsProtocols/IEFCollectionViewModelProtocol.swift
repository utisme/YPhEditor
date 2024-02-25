//
//  IEFCollectionViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit

protocol IEFCollectionViewModelProtocol {
    
    func getDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Int, Int>
}
