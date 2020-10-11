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
    var objectID: String
    var created_at: String
    var author: String
    var story_title: String?
    var title: String?
    var story_url: String?
    

    
    
    private enum CodingKeys : String, CodingKey { case objectID, created_at, story_title, title, author, story_url}

     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        objectID = try container.decode(String.self, forKey: .objectID)
        created_at = try container.decode(String.self, forKey: .created_at)
        author = try container.decode(String.self, forKey: .author)
        story_title = try container.decodeIfPresent(String.self, forKey: .story_title)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        story_url = try container.decodeIfPresent(String.self, forKey: .story_url)
    }
}
