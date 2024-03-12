//
//  IECollectionView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 19.02.24.
//

import UIKit
import RxSwift
import RxCocoa

final class IECollectionView: BaseView {
    
    private let viewModel: IECollectionViewModelProtocol
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = IECollectionViewLayout()
        collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }()
    
    private var collectionView: UICollectionView!
    
    init(viewModel: IECollectionViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewModel.prepareData(for: collectionView)
        viewModel.collectionDidLoaded()
        
//        configureScrollReaction()
//        configureTapReaction()
    }
    
//    private func configureTapReaction() {
//        collectionView.rx.itemSelected.asDriver()
//            .drive(onNext: { [weak self] indexPath in
//                let targetItem = indexPath.item
//                self?.collectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .centeredHorizontally, animated: false)
//                self?.viewModel.cellChanged()
//            })
//            .disposed(by: viewModel.disposeBag)
//    }
//    
//    private func configureScrollReaction() {
//        collectionView.rx.contentOffset.asDriver()
//            .drive(onNext: { [weak self] _ in
//                self?.viewModel.cellChanged()
//            })
//            .disposed(by: viewModel.disposeBag)
//    }
}

extension IECollectionView {
    
    override func setConfigurations() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(IEFCollectionViewCell.self, forCellWithReuseIdentifier: IEFCollectionViewCell.id)
        collectionView.register(IEECollectionViewCell.self, forCellWithReuseIdentifier: IEECollectionViewCell.id)
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

extension IECollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetItem = indexPath.item
        collectionView.scrollToItem(at: IndexPath(item: targetItem, section: 0), at: .centeredHorizontally, animated: false)
        viewModel.cellChanged()
    }
}

extension IECollectionView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.cellChanged()
    }
}
