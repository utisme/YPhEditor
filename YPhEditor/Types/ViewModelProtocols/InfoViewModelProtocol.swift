//
//  InfoViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import Foundation

protocol InfoViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellConfigurations(for indexPath: IndexPath) -> (cellTitle: String?, cellValue: String?)
}
