//
//  InfoViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import UIKit

final class InfoViewController: BaseViewController {
    
    let viewModel: InfoViewModelProtocol
    
    let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel: InfoViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
}

extension InfoViewController {
    override func setConfigurations() {
        super.setConfigurations()
        
        collectionView.dataSource = self
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.id)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        collectionView.backgroundColor = .clear
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(collectionView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.id, for: indexPath) as? InfoCollectionViewCell else { return InfoCollectionViewCell() }
        
        let cellConfigurations = viewModel.cellConfigurations(for: indexPath)
        cell.configure(withLabel: cellConfigurations.cellTitle, value: cellConfigurations.cellValue)
        return cell
    }
    
}
