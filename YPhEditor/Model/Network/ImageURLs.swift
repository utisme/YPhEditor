//
//  ImageURLs.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 8.02.24.
//

import Foundation

struct ImageURLs: Decodable {
    
    enum FirstContainer: String, CodingKey {
        case urls
    }
    
    enum SecondContainer: String, CodingKey {
        case url = "regular"
    }

    let full: String
    
    init(from decoder: Decoder) throws {
        
        let rootContainer = try decoder.container(keyedBy: FirstContainer.self)
        
        let nestedContainer = try rootContainer.nestedContainer(keyedBy: SecondContainer.self, forKey: .urls)
        self.full = try nestedContainer.decode(String.self, forKey: .url)
    }
}


