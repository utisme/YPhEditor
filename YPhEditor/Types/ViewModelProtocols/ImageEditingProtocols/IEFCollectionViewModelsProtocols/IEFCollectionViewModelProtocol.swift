//
//  IEFCollectionViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit

protocol IEFCollectionViewModelProtocol {
    
    var currentCell: (IEFCollectionViewCell, Int) { get }
    func prepareData(for collectionView: UICollectionView)
    func configureForFilters()
    func configureForEffects()
    func collectionDidLoaded()
    func cellChanged()
}
