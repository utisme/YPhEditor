//
//  SettingsViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    let viewModel: SettingsViewModelProtocol
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) { nil }
}

extension SettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
