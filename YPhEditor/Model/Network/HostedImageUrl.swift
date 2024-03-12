//
//  HostedImageUrl.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.03.24.
//

import Foundation

struct HostedImageUrl: Decodable {
    
    enum FirstContainer: String, CodingKey {
        case data
    }
    
    enum SecondContainer: String, CodingKey {
        case url
    }

    let url: String
    
    init(from decoder: Decoder) throws {
        
        let rootContainer = try decoder.container(keyedBy: FirstContainer.self)
        
        let nestedContainer = try rootContainer.nestedContainer(keyedBy: SecondContainer.self, forKey: .data)
        self.url = try nestedContainer.decode(String.self, forKey: .url)
    }
}
