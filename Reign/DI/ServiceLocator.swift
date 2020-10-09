//
//  ServiceLocator.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

class ServiceLocator {
    
//MARK: - Use cases
    var getNews: GetNews {
        return GetNews(repository: repository)
    }


//MARK: - Repositories
    var repository: Repository {
        return NewsRepository(apiClient: apiClient)
    }
    

//MARK: - Datasources
    var apiClient: NewsAPIClient {
        return NewsAPIClient.shared
    }

}
