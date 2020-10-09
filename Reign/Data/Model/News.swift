//
//  News.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct Response: Codable {
    var hits: [News]
}

struct News: Codable {
    var created_at: String
    var story_title: String?
    var title: String?
    var author: String?
    
    
    private enum CodingKeys : String, CodingKey { case created_at, story_title, title, author}

     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try container.decode(String.self, forKey: .created_at)
        story_title = try container.decodeIfPresent(String.self, forKey: .story_title)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        author = try container.decodeIfPresent(String.self, forKey: .author)
    }
}
