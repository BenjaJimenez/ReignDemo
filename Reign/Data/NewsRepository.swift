//
//  NewsRepository.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

protocol Repository {
    func getNews(completion: @escaping ([News]?, _ cache: Bool) -> Void)
    func ignoreNews(id: String)
    func getIgnoreList() -> [String]
    func storeNews(_ news:[News])
}

struct NewsRepository: Repository {
    
    var apiClient: NewsAPIClient
    var localDatasource: LocalDatasource
    
    func getNews(completion: @escaping ([News]?, _ cache: Bool) -> Void) {
        apiClient.getNews { (success, response) in
            if success, let response = response, response.count > 0 {
                completion(response, false)
            }else {
                completion(localDatasource.getNews(), true)
            }
        }
    }
    
    func ignoreNews(id: String) {
        localDatasource.ignoreNewsItem(id: id)
    }
    
    func getIgnoreList() -> [String] {
        return localDatasource.getIgnoredList()
    }
    
    func storeNews(_ news: [News]) {
        localDatasource.store(news)
    }
}

