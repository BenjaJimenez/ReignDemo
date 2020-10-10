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
    
    var ignoreNews: IgnoreNews {
        return IgnoreNews(repository: repository)
    }
    
    var storeNews: StoreNews {
        return StoreNews(repository: repository)
    }


//MARK: - Repositories
    var repository: Repository {
        return NewsRepository(apiClient: apiClient, localDatasource: localDatasource)
    }
    

//MARK: - Datasources
    var apiClient: NewsAPIClient {
        return NewsAPIClient.shared
    }
    
    var localDatasource: LocalDatasource {
        return LocalDatasource.shared
    }

//MARK: - Mappers
    var itemMapper: ItemMapper {
        return ItemMapper()
    }
}
