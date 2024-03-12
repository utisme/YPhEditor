//
//  IEFCollectionViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 20.02.24.
//

import Foundation
import UIKit
import RxSwift

protocol IECollectionViewModelProtocol {
    
    var disposeBag: DisposeBag { get }
    var currentCell: (UICollectionViewCell, Int) { get }
    func prepareData(for collectionView: UICollectionView)
    func configureForFilters()
    func configureForEffects()
    func updateCollection()
    func collectionDidLoaded()
    func cellChanged()
    
    func prepareImageForEffectCell(_ image: CIImage, to view: MetalImageView) -> CIImage
}
