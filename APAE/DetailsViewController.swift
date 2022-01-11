//
//  DetailsViewController.swift
//  APAE
//
//  Created by Rui Costa on 11/01/2022.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource{
    
    
static let identifier = "DetailsViewController"
    
    var article: Article?
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.register(NewsDetailTableViewCell.self, forCellReuseIdentifier: NewsDetailTableViewCell.identifier)
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    private var viewModels : NewsDetailTableViewCellViewModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        
        title = "Detail"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
      /*  self.viewModels = article({
            NewsDetailTableViewCellViewModel(
             title: $0.title,
             summary: $0.summary ?? "Sem Descrição para mostrar",
             imageURL: URL(string: $0.imageUrl ?? ""),
             newsSite: $0.newsSite ?? "Sem autor",
             publishedAt: $0.publishedAt ?? ""
            )
         
        })*/
        
       /* NewsDetailTableViewCellViewModel(
        title: article?.title ?? "Sem Titulo" ,
         summary: article?.summary ?? "Sem Descrição para mostrar",
         imageURL: URL(string: article?.imageUrl ?? ""),
         newsSite: article?.newsSite ?? "Sem autor",
         publishedAt: article?.publishedAt ?? ""
        ) */
        
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
        
        
        
    }
    
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame =  view.bounds
        
        
    }
 
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsDetailTableViewCell.identifier,
            for: indexPath
        )as? NewsDetailTableViewCell else {
            fatalError()
        }
        
        cell.authorLabel.text = article?.newsSite
        cell.publishedAtLabel.text = article?.publishedAt
        cell.newsTitleLabel.text = article?.title
        cell.subTitleLabel.text = article?.summary
        
        
       // let data = viewModels?.imageData
       // cell.newsImageView.image = UIImage(data: (data ?? viewModels?.imageData))
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = article
        
        guard let url = URL (string: article?.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}
