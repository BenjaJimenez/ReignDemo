//
//  NewsPresenter.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import Foundation

struct Item {
    var id: String
    var title: String
    var author: String
    var date: String
}

struct NewsPresenter {
    
    var getNews: GetNews
    var ui: NewsUI?
    
    init(getNews: GetNews, ui: NewsUI) {
        self.getNews = getNews
        self.ui = ui
        loadData()
    }
        
    func loadData(){
        let example = [
            Item(id: "1",title: "title",author: "author", date: "date"),
            Item(id: "2",title: "title",author: "author",date:"date"),
            Item(id: "3",title: "title",author: "author",date:"date"),
            Item(id: "4",title: "title",author: "author",date:"date")
        ]
        getNews.execute{ news in
            print(news)
        }
        ui?.displayNews(items: example)
    }
    
    func deleteItem(id: String){
        
    }
}

protocol NewsUI {
    func displayNews(items: [Item])
}
