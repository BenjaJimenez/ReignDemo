//
//  StoreNews.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct StoreNews {
    
    var repository: Repository
    
    func set(_ news: [News]){
        repository.storeNews(news)
    }
}
