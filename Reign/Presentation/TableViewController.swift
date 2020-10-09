//
//  ViewController.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import UIKit

struct Item {
    var id: String
    var title: String
    var author: String
    var date: String
}

let example = [
    Item(id: "1",title: "title",author: "author", date: "date"),
    Item(id: "2",title: "title",author: "author",date:"date"),
    Item(id: "3",title: "title",author: "author",date:"date"),
    Item(id: "4",title: "title",author: "author",date:"date")
]

class TableViewController: UITableViewController {

    var news: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        news = example
        tableView.reloadData()
    }
    
    func remove(at index: Int) {
        news.remove(at: index)
    }
    
    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
            news = example
            tableView.reloadData()
            sender.endRefreshing()
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

fileprivate struct Const {
    static let identifier = "cell"
}
