//
//  ImageURLs.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 8.02.24.
//

import Foundation

struct ImageURLs: Decodable {
    
    enum CodingUrlsKey: String, CodingKey {
        case urls
    }
    
    enum CodingUrl: String, CodingKey {
        case url = "regular"
    }

    let full: String
    
    init(from decoder: Decoder) throws {
        
        let rootContainer = try decoder.container(keyedBy: CodingUrlsKey.self)
        
        let nestedContainer = try rootContainer.nestedContainer(keyedBy: CodingUrl.self, forKey: .urls)
        self.full = try nestedContainer.decode(String.self, forKey: .url)
    }
}
