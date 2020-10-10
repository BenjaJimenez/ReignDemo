//
//  NewsRepository.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

protocol Repository {
    func getNews(completion: @escaping ([News]?) -> Void)
    func ignoreNews(id: String)
    func getIgnoreList() -> [String]
}

struct NewsRepository: Repository {
    
    var apiClient: NewsAPIClient
    var localDatasource: LocalDatasource
    
    func getNews(completion: @escaping ([News]?) -> Void) {
        apiClient.getNews { (success, response) in
            if success, let response = response, response.count > 0 {
                completion(response)
            }
        }
    }
    
    func ignoreNews(id: String) {
        localDatasource.ignoreNewsItem(id: id)
    }
    
    func getIgnoreList() -> [String] {
        return localDatasource.getIgnoredList()
    }
}

