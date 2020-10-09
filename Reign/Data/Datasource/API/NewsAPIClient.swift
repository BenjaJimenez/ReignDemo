//
//  NewsAPIClient.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

public class NewsAPIClient: APIClient {
    
    public static let shared = NewsAPIClient()
    
    func getNews(completionHandler: ((_: Bool, _: [News]?) -> ())?){
        guard let url = URL(string:"https://hn.algolia.com/api/v1/search_by_date?query=ios") else {
            completionHandler?(false, nil)
            return
        }
        
        performGenericCall(URL: url, method: .GET, contentType: .json){ (success: Bool, response: URLResponse?, data: Data?) in
            if success, let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completionHandler?(true, response.hits)
                } catch let error {
                    print("Decoder failed with error: \(error)")
                    completionHandler?(false, nil)
                }
            } else {
                completionHandler?(false, nil)
            }
        }
    }
}
