//
//  IECollectionViewLayout.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 21.02.24.
//

import UIKit

final class IECollectionViewLayout: UICollectionViewFlowLayout {
    
    var currentItemIndex: Int? {
        guard let collectionView else { return 0 }
        let cellWithSpacing = itemSize.width + minimumInteritemSpacing
        let cellIndex = (collectionView.contentInset.left + collectionView.contentOffset.x) / cellWithSpacing
        return Int(cellIndex)
    }

// MARK: - Inset
    private var centerInset: UIEdgeInsets {
        
        guard let collectionView else { return UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero) }
        let center: CGFloat = (collectionView.bounds.width - itemSize.width) / 2
        return UIEdgeInsets(top: .zero, left: center, bottom: .zero, right: center)
    }
    
    private var itemsCount: CGFloat {
        
        guard let collectionView else { return .zero }
        
        let cellWithSpacing = itemSize.width + minimumInteritemSpacing
        let usefullWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        return floor(usefullWidth / cellWithSpacing)
    }
    
    override func prepare() {
        
        super.prepare()
        collectionView?.contentInset = centerInset
    }
 
// MARK: - Return to the cell center
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }
        
        let cellWithSpacing = itemSize.width + minimumInteritemSpacing
        let targetCell = (proposedContentOffset.x + collectionView.contentInset.left + (cellWithSpacing / 2)) / cellWithSpacing
        let leftIndex = max(0, floor(targetCell))
        let rightIndex = min(ceil(targetCell), itemsCount)
        let leftCenter = leftIndex * cellWithSpacing - collectionView.contentInset.left
        let rightCenter = rightIndex * cellWithSpacing - collectionView.contentInset.left
        
        if abs(leftCenter - proposedContentOffset.x) < abs(rightCenter - proposedContentOffset.x) {
            return CGPoint(x: leftCenter, y: proposedContentOffset.y)
        } else {
            return CGPoint(x: rightCenter, y: proposedContentOffset.y)
        }
    }
}
