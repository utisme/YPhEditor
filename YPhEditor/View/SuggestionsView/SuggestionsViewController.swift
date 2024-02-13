//
//  SuggestionsViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.02.24.
//

import UIKit
import RxSwift

final class SuggestionsViewController: BaseViewController {
    
// MARK: PROPERTIES
    var viewModel: SuggestionsViewModelProtocol?
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = Resources.Colors.element
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
    
    let footer: UIImageView = {
        let footer = UIImageView()
        footer.image = Resources.Images.Suggestions.downArrow
        footer.tintColor = Resources.Colors.element
        return footer
    }()
    
// MARK: - CONFIGURATIONS
    func subscribeToViewModel() {
        guard let viewModel else { return }
        viewModel.imagesObservable
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            })
            .disposed(by: viewModel.disposeBag)
        viewModel.configure()
    }
}

extension SuggestionsViewController {
    
    override func configure() {
        super.configure()
        
        subscribeToViewModel()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SuggestionsCollectionViewCell.self, forCellWithReuseIdentifier: SuggestionsCollectionViewCell.id)
        
        activityIndicator.startAnimating()
    }
    
// MARK: APPEARANCE
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(blurView, activityIndicator, footer, collectionView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        footer.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(footer.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: COLLECTION VIEW CONFIGURATION
extension SuggestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // NUMBER OF ITEMS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getNumberOfCells() ?? 0
    }
    
    // CELL FOR ROW
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsCollectionViewCell.id, for: indexPath)
                as? SuggestionsCollectionViewCell
        else { return UICollectionViewCell() }
        
        let image = viewModel?.getImageForCell(at: indexPath)
        cell.configure(withImage: image)
        return cell
    }
    
    // SIZE FOR ITEM
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel?.getSizeForCell(at: collectionView) ?? CGSize()
    }
    
    // DID SELECT ITEM
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCell(withIndexPath: indexPath)
        dismiss(animated: true)
    }
}
