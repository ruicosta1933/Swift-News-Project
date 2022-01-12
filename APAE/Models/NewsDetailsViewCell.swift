//
//  NewsTableViewCell.swift
//  APAE
//
//  Created by Rui Costa on 20/12/2021.
//

import UIKit

class NewsDetailTableViewCellViewModel {
    let title : String
    let summary : String
    let imageURL : URL?
    var imageData: Data? = nil
    var newsSite: String?
    var publishedAt: String?
    
    init(
        title : String,
        summary : String,
        imageURL : URL?,
        newsSite : String,
        publishedAt : String
    ){
        self.title = title
        self.summary = summary
        self.imageURL = imageURL
        self.newsSite = newsSite
        self.publishedAt = publishedAt
    }
}

class NewsDetailTableViewCell: UITableViewCell {
    
static let identifier = "NewsDetailTableViewCell"
    
    
    
    
     let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         
        return label
    }()
     let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
     let newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
     let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .thin)
        return label
    }()
     let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    let textField: UITextField = {
       let label = UITextField()
        var red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.layer.borderWidth = 2
        label.layer.borderColor = red.cgColor
        label.placeholder = " Nome"
       return label
   }()
    let commentField: UITextView = {
       let label = UITextView()
        var red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.layer.borderWidth = 2
        label.layer.borderColor = red.cgColor
       return label
   }()
    let buttonField: UIButton = {
        let label = UIButton(type: .system)
        var red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        label.frame =  CGRect(x: 20, y: 20, width: 100, height: 50)
        label.setTitle("Comentar", for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        label.layer.borderWidth = 2
        label.layer.borderColor = red.cgColor
       return label
   }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publishedAtLabel)
        contentView.addSubview(textField)
        contentView.addSubview(buttonField)
        contentView.addSubview(commentField)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame=CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.size.width-10,
            height: contentView.frame.size.height + 60
        )
        
        subTitleLabel.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.size.width-10,
            height: contentView.frame.size.height+200
        )
        
        newsImageView.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.frame.size.width-10,
            height: contentView.frame.size.height/2
        )
        authorLabel.frame = CGRect(
            x: contentView.frame.size.width-140,
            y: 5,
            width: contentView.frame.size.width-70,
            height: contentView.frame.size.height+320
        )
        publishedAtLabel.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.size.width-70,
            height: contentView.frame.size.height+320
        )
        buttonField.frame = CGRect(
            x: contentView.frame.size.width/2.8,
            y: 834,
            width: 100,
            height: 50
        )
        textField.frame = CGRect(
            x: contentView.frame.size.width/4,
            y: 700,
            width: 200,
            height: 30
        )
        commentField.frame = CGRect(
            x: contentView.frame.size.width/4,
            y: 732,
            width: 200,
            height: 100
        )
        
    }
   
    override func prepareForReuse() {
         super.prepareForReuse()
        newsTitleLabel.text = nil
        subTitleLabel.text = nil
        newsImageView.image = nil
        authorLabel.text = nil
        publishedAtLabel.text = nil
        textField.text = nil
    }
    
    func configure(with viewModel : NewsDetailTableViewCellViewModel ){
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.summary
        authorLabel.text = viewModel.newsSite
        publishedAtLabel.text = viewModel.publishedAt
        
        //Image
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL{
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
        }
    }

}
