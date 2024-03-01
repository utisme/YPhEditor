//
//  MenuImagePickerAlert.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 12.02.24.
//

// TODO: - сделать проверку на наличие currentImage в core data, и расширять алерт если проверка успешна

import UIKit

final class MenuImagePickerAlert: UIAlertController {
    
    private var completion: ((UIAlertAction)->())?
    
    convenience init(completion: ((UIAlertAction)->Void)? = nil) {
        self.init(
            title: Resources.Strings.Gallery.alertTitle,
            message: nil,
            preferredStyle: .actionSheet)
        self.completion = completion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigurations()
    }
}

extension MenuImagePickerAlert {
    
    private func setConfigurations() {
        
        let alertActionGallery = UIAlertAction(
            title: Resources.Strings.Gallery.alertActionGallery,
            style: .default,
            handler: completion)
        addAction(alertActionGallery)
        
        let alertActionCamera = UIAlertAction(
            title: Resources.Strings.Gallery.alertActionCamera,
            style: .default,
            handler: completion)
        addAction(alertActionCamera)
        
        let alertActionCancel = UIAlertAction(
            title: Resources.Strings.Gallery.alertActionCancel,
            style: .cancel) { _ in
                self.dismiss(animated: true)
            }
        addAction(alertActionCancel)
    }
}


