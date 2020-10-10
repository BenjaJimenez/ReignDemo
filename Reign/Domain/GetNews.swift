//
//  GetNews.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct GetNews {
    var repository: Repository
    
    func execute(completion: @escaping ([News]?, _ cache: Bool) -> Void){
        repository.getNews(completion: completion)
    }
}
