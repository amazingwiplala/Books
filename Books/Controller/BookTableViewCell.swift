//
//  BookTableViewCell.swift
//  Books
//
//  Created by Jeanine Chuang on 2023/8/14.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var CoverImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var PublishedDateLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet weak var PublisherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ item:Item){
        TitleLabel.text = item.volumeInfo.title
        if let authors = item.volumeInfo.authors {
            AuthorLabel.text = ""
            for author in authors  {
                AuthorLabel.text?.append(author + " ")
            }
        }
        PublishedDateLabel.text = item.volumeInfo.publishedDate
        PublisherLabel.text = item.volumeInfo.publisher
        if let inds = item.volumeInfo.industryIdentifiers {
            for isbn in inds {
                if isbn.type == "ISBN_13" {
                    ISBNLabel.text  = isbn.identifier
                }
            }
        }
        updateCover(item)
    }
    
    func updateCover(_ item:Item){
        
        if let urlStr = item.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://"), let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url ) { data, response , error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.CoverImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }else{
            self.CoverImageView.image = UIImage(named: "nocover")
        }
    }

}
