//
//  ItemMapper.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

fileprivate let inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

struct ItemMapper {
    
    var inputFormatter = DateFormatter()
    var viewFormatter = RelativeDateTimeFormatter()
    
    init() {
        inputFormatter.dateFormat = inputFormat
        viewFormatter.dateTimeStyle = .named
    }
    
    func mapAll(_ news: [News], filterList: [String]) -> [Item] {
        var items: [Item] = []
        for article in news {
            if filterList.contains(article.objectID) {
                continue
            }
            
            if let item = map(from: article) {
                items.append(item)
            }
        }
        return items
    }
    
    func map(from article: News) -> Item? {
        
        let title = article.story_title ?? article.title ?? ""
        let author = article.author
        let date = inputFormatter.date(from: article.created_at)
        
        return Item(id: article.objectID, title: title, author: author, date: viewFormatter.string(for: date) ?? "")
    }
}
