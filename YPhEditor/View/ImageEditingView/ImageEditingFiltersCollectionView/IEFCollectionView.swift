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
        
        dataSource = viewModel.getDataSource(for: collectionView)
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0, 10, 20, 30, 40, 50 , 60, 70, 80, 90, -10, -20])
        dataSource.apply(snapshot, animatingDifferences: true)
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
        
        let targetItem = indexPath.item
        collectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension IEFCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let collectionViewFlowLayout = collectionView.collectionViewLayout as? IEFCollectionViewLayout
        else { return }
        
        print("current cell index: ", collectionViewFlowLayout.currentItemIndex)
    }
}
