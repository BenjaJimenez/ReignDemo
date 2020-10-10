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
    var storeNews: StoreNews
    var mapper: ItemMapper
    var ui: NewsUI?
    
    init(getNews: GetNews, ignoreNews: IgnoreNews, storeNews: StoreNews, mapper: ItemMapper, ui: NewsUI) {
        self.getNews = getNews
        self.ignoreNews = ignoreNews
        self.storeNews = storeNews
        self.mapper = mapper
        self.ui = ui
        loadData()
    }
        
    func loadData(){
        getNews.execute{ news, cache in
            if let news = news, news.count > 0 {
                let items = mapper.mapAll(news, filterList: ignoreNews.getAll())
                OperationQueue.main.addOperation {
                    ui?.displayNews(items: items)
                }
                if !cache {
                    storeNews.set(news)
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
