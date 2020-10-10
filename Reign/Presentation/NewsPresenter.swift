//
//  NewsPresenter.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct NewsPresenter {
    
    var getNews: GetNews
    var ignoreNews: IgnoreNews
    var mapper: ItemMapper
    var ui: NewsUI?
    
    init(getNews: GetNews, ignoreNews: IgnoreNews, mapper: ItemMapper, ui: NewsUI) {
        self.getNews = getNews
        self.ignoreNews = ignoreNews
        self.mapper = mapper
        self.ui = ui
        loadData()
    }
        
    func loadData(){
        getNews.execute{ news in
            if let news = news {
                let items = mapper.mapAll(news, filterList: ignoreNews.getAll())
                if items.count > 0 {
                    OperationQueue.main.addOperation {
                        ui?.displayNews(items: items)
                    }
                }
            }
        }
    }
    
    func deleteItem(id: String){
        ignoreNews.add(id: id)
    }
}

protocol NewsUI {
    func displayNews(items: [Item])
}
