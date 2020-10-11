//
//  ViewController.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import UIKit
import WebKit

class TableViewController: UITableViewController {

    var news: [Item] = []
    var locator = ServiceLocator()
    var presenter : NewsPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsPresenter(getNews: locator.getNews, ignoreNews: locator.ignoreNews, storeNews: locator.storeNews, mapper: locator.itemMapper, ui: self)
    }
    
    func remove(at index: Int) {
        let item = news[index]
        news.remove(at: index)
        presenter?.deleteItem(id: item.id)
    }

    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
        presenter?.loadData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = news[indexPath.row]
        presenter?.selectedItem(id: item.id)
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func displayMessage(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayURL(url: URL){
        displayWebView(url: url)
    }
}

// MARK: - Router

extension TableViewController {
    func displayWebView(url: URL) {
        
        let controller = UIViewController()
        let webView = WKWebView()
        controller.view.addSubview(webView)
        
        //Constraints
        webView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        
        //Navbar back button
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        let navController = UINavigationController(rootViewController: controller)
        
        self.present(navController, animated:true) {
            webView.load(URLRequest(url: url))
        }
        
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
}

fileprivate struct Const {
    static let identifier = "cell"
}
