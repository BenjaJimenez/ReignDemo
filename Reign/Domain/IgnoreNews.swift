//
//  IgnoreNews.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct IgnoreNews {
    var repository: Repository
    
    func add(id: String) {
        repository.ignoreNews(id: id)
    }
    
    func getAll() -> [String] {
        return repository.getIgnoreList()
    }
}
