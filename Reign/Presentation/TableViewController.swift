//
//  ViewController.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import UIKit

class TableViewController: UITableViewController {

    var news: [Item] = []
    var locator = ServiceLocator()
    var presenter : NewsPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsPresenter(getNews: locator.getNews, mapper: locator.itemMapper, ui: self)
    }
    
    func remove(at index: Int) {
        news.remove(at: index)
    }

    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
        presenter?.loadData()
        refreshControl = sender
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.identifier, for: indexPath) as! TableViewCell
        cell.configure(news[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UI
extension TableViewController: NewsUI {
    func displayNews(items: [Item]){
        news = items
        tableView.reloadData()
        if let control = refreshControl, control.isRefreshing {
            control.endRefreshing()
        }
    }
}

fileprivate struct Const {
    static let identifier = "cell"
}
