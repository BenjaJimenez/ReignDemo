//
//  LocalDatasource.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct LocalDatasource {
    
    public static let shared = LocalDatasource()
    
    func ignoreNewsItem(id: String){

        var ignoredList = getIgnoredList()
        ignoredList.append(id)
    
        UserDefaults.standard.setValue(ignoredList, forKey: Constants.ignoreListKey)
        UserDefaults.standard.synchronize()
    }
    
    func getIgnoredList() -> [String] {
        var ignoredList: [String] = []
    
        if let list = UserDefaults.standard.object(forKey: Constants.ignoreListKey) as? [String] {
            ignoredList = list
        }
        return ignoredList
    }
    
    func getNews() -> [News] {
        var cacheList: [News] = []
        do {
            if let o = UserDefaults.standard.object(forKey: Constants.cacheListKey) as? Data {
                cacheList = try JSONDecoder().decode([News].self, from: o)
            }
        } catch let err {
            print(err)
        }
        return cacheList
    }
    
    func store(_ items: [News]) {
        do {
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encoded, forKey: Constants.cacheListKey)
        } catch let error {
            print(error)
        }
    }
}

fileprivate struct Constants {
    static let ignoreListKey = "IgnoreListKey"
    static let cacheListKey = "CacheListKey"
}
