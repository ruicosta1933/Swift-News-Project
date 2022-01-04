//
//  ViewController.swift
//  APAE
//
//  Created by Rui Costa on 20/12/2021.
//

import UIKit
import SafariServices

class UINews: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Blog"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        
        APICaller.shared.getBlog{ [weak self] result in
                   switch result {
                   case .success(let articles):
                       self?.articles = articles
                       self?.viewModels = articles.compactMap({
                           NewsTableViewCellViewModel(
                            title: $0.title,
                            summary: $0.summary ?? "Sem Descrição para mostrar",
                            imageURL: URL(string: $0.imageUrl ?? ""),
                            newsSite: $0.newsSite ?? "Sem autor",
                            publishedAt: $0.publishedAt ?? ""
                           )
                        
                       })
                       
                       DispatchQueue.main.async {
                           self?.tableView.reloadData()
                       }
                   case .failure(let error):
                       print(error)
                   }
               }
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame =  view.bounds
        
        
    }
    
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        )as? NewsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL (string: article.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    //Search


}

