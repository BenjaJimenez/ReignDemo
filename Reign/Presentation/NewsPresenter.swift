//
//  NewsPresenter.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

class NewsPresenter {
    
    var getNews: GetNews
    var ignoreNews: IgnoreNews
    var storeNews: StoreNews
    var mapper: ItemMapper
    weak var ui: NewsUI?
    
    var news = [News]()
    
    init(getNews: GetNews, ignoreNews: IgnoreNews, storeNews: StoreNews, mapper: ItemMapper, ui: NewsUI) {
        self.getNews = getNews
        self.ignoreNews = ignoreNews
        self.storeNews = storeNews
        self.mapper = mapper
        self.ui = ui
        loadData()
    }
        
    func loadData(){
        getNews.execute{ [weak self] news, cache in
            guard let self = self else {
                return
            }
            
            if let news = news, news.count > 0 {
                self.news = news
                let items = self.mapper.mapAll(news, filterList: self.ignoreNews.getAll())
                OperationQueue.main.addOperation {
                    self.ui?.displayNews(items: items)
                }
                if !cache {
                    self.storeNews.set(news)
                }
            }
        }
    }
    
    func deleteItem(id: String){
        ignoreNews.add(id: id)
    }
    
    func selectedItem(id: String){
        for item in news {
            if item.objectID == id {
                if let url = URL(string: item.story_url ?? "") {
                    ui?.displayURL(url: url)
                }else {
                    ui?.displayMessage(msg: "No URL available for article")
                }
                return
            }
        }
        ui?.displayMessage(msg: "Article not found")
    }
}

protocol NewsUI: class {
    func displayNews(items: [Item])
    func displayMessage(msg: String)
    func displayURL(url: URL)
}
