//
//  DetailsViewController.swift
//  APAE
//
//  Created by Rui Costa on 11/01/2022.
//

import UIKit

class DetailsViewController: UIViewController{
    
    
static let identifier = "DetailsViewController"
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    var article: Article?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(article)
    }
    
    func configure(with article: Article){
        
        print(article)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
