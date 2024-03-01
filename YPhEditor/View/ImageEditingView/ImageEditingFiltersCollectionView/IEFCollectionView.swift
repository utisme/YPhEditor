//
//  IEFCollectionView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 19.02.24.
//

import UIKit

final class IEFCollectionView: BaseView {
    
    private let viewModel: IEFCollectionViewModelProtocol = IEFCollectionViewModel()
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = IEFCollectionViewLayout()
        collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }()
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewModel.setupDataSource(for: collectionView)
    }
}

extension IEFCollectionView {
    
    override func setConfigurations() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(IEFCollectionViewCell.self, forCellWithReuseIdentifier: IEFCollectionViewCell.id)
    }
    
    override func configureAppearance() {
        
        collectionView.backgroundColor = .clear
    }
    
    override func setupSubviews() {
        
        addSubviews(collectionView)
    }
    
    override func constraintSubviews() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension IEFCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? IEFCollectionViewCell
        else { return }         //TODO: -handle error
        
        let targetItem = indexPath.item
        collectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .centeredHorizontally, animated: true)
        
        viewModel.setCurrentFilter(as: targetItem)
        viewModel.setCellConfigurations(for: cell)
    }
}

extension IEFCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let collectionViewFlowLayout = collectionView.collectionViewLayout as? IEFCollectionViewLayout,
              let currentItemIndex = collectionViewFlowLayout.currentItemIndex,
              let cell = collectionView.cellForItem(at: IndexPath(item: Int(currentItemIndex), section: 0)) as? IEFCollectionViewCell
        else { return }             // TODO: - handle error
        
        viewModel.setCurrentFilter(as: Int(currentItemIndex))
        viewModel.setCellConfigurations(for: cell)
    }
}
