//
//  NewsRepository.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

protocol Repository {
    func getNews(completion: @escaping ([News]?) -> Void)
}

struct NewsRepository: Repository {
    
    var apiClient: NewsAPIClient
    
    func getNews(completion: @escaping ([News]?) -> Void) {
        apiClient.getNews { (success, response) in
            if success, let response = response, response.count > 0 {
                completion(response)
            }
        }
    }
}

