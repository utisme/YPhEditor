//
//  IEFCollectionView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 19.02.24.
//

import UIKit
import RxSwift
import RxCocoa

final class IEFCollectionView: BaseView {
    
    private let viewModel: IEFCollectionViewModelProtocol
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = IEFCollectionViewLayout()
        collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }()
    
    private var collectionView: UICollectionView!
    
    init(viewModel: IEFCollectionViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewModel.prepareData(for: collectionView)
        viewModel.collectionDidLoaded()
    }
}

extension IEFCollectionView {
    
    override func setConfigurations() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
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
//        collectionView.rx.itemSelected.asDriver()
//            .drive(onNext: { [weak self ] indexPath in
//                
//            }).disposed(by: )
    }
}

extension IEFCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetItem = indexPath.item
        collectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .centeredHorizontally, animated: false)
        viewModel.cellChanged()
    }
}

extension IEFCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.cellChanged()
    }
}
