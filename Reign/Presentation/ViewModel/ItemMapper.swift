//
//  ItemMapper.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct ItemMapper {
    
    func mapAll(_ news: [News]) -> [Item] {
        var items: [Item] = []
        for article in news {
            if let item = map(from: article) {
                items.append(item)
            }
        }
        return items
    }
    
    func map(from article: News) -> Item? {
        
        let title = article.story_title ?? article.title ?? ""
        let author = article.author ?? ""
        let date = article.created_at
        
        return Item(id: date+title, title: title, author: author, date: date)
    }
    
}
