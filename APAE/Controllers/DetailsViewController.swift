//
//  DetailsViewController.swift
//  APAE
//
//  Created by Rui Costa on 11/01/2022.
//

import UIKit
import SafariServices
import FirebaseDatabase

class DetailsViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource{
    
    
static let identifier = "DetailsViewController"
    
    var article: Article?
    var image: Data? = nil
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.register(NewsDetailTableViewCell.self, forCellReuseIdentifier: NewsDetailTableViewCell.identifier)
        return table
    }()
    private let ref = Database.database(url: "https://apae-d1ea4-default-rtdb.europe-west1.firebasedatabase.app").reference()
    private let searchVC = UISearchController(searchResultsController: nil)
    private var viewModels : NewsDetailTableViewCellViewModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        
        
        
        print(ref)
        
        //ref.child("comentarios/comentario/nome").setValue("Miguel")
        
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
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame =  view.bounds
        
        
    }
 
    @objc func pressed() {
        guard let cell = self.tableView.dequeueReusableCell(
            withIdentifier: NewsDetailTableViewCell.identifier
        )as? NewsDetailTableViewCell else {
            fatalError()
        }
        
        
        
        if cell.textField.placeholder != "" || cell.textField.text != nil {
            
            print(cell.textField.placeholder)
            if cell.commentField.text != "" || cell.commentField.text != nil {
                print(cell.commentField.delegate)
                let alert = UIAlertController(title: "Sucesso", message: "O seu comentário foi enviado.", preferredStyle: .alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            else{
                print("O comentario nao esta preenchido")
                let alert = UIAlertController(title: "Erro", message: "Ainda não fez o seu comentário.", preferredStyle: .alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            print("O nome nao esta preenchido")
            let alert = UIAlertController(title: "Erro", message: "O seu nome não está preenchido.", preferredStyle: .alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    @objc func liked() {
        let link = article?.url
        
        ref.child("likes").setValue(["news" : link, "likes" : 1])
        
        let alert = UIAlertController(title: "Sucesso", message: "A sua avaliação foi registada.", preferredStyle: .alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
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
        cell.newsImageView.image = UIImage(data: image!)
        
        
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
        return 1000
    }

}
