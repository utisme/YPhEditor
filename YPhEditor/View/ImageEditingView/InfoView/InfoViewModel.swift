//
//  InfoViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import Foundation
import UIKit

final class InfoViewModel: InfoViewModelProtocol {
    
    private var metaData: [String: String]? = [:]
    
    init() {
        guard let currentUIImage = CurrentImageManager.shared.currentUIImage,
              let metaData = ImageProcessingManager.Tools.getMetadataFromImage(currentUIImage) else {
            self.metaData = [Resources.Strings.ImageEditing.Info.noDataLeft: Resources.Strings.ImageEditing.Info.noDataRight]
            return
        }
    }
    
    func numberOfRowsInSection() -> Int {
        guard let output = metaData?.count else { return 0 }             //TODO: handle error
        
        return output
    }
    
    func cellConfigurations(for indexPath: IndexPath) -> (cellTitle: String?, cellValue: String?) {
        let element = metaData?.sorted(by: { $0.key > $1.key })[indexPath.row]      //TODO: поправить множественную сортировку
        return (element?.key, element?.value)
    }
}
