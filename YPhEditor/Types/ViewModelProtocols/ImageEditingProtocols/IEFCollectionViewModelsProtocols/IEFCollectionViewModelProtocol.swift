//
//  IEFCollectionViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit

protocol IEFCollectionViewModelProtocol {
    
    func setupDataSource(for collectionView: UICollectionView)
    func setCurrentFilter(as rawValue: Int)
    func setCellConfigurations(for cell: IEFCollectionViewCell)
}
