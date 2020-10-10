//
//  LocalDatasource.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct LocalDatasource {
    
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
        print(ignoredList)
        return ignoredList
    }
}

fileprivate struct Constants {
    static let ignoreListKey = "IgnoreListKey"
}
