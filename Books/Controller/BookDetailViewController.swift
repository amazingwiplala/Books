//
//  BookDetailViewController.swift
//  Books
//
//  Created by Jeanine Chuang on 2023/8/15.
//

import UIKit
import SafariServices

class BookDetailViewController: UIViewController, SFSafariViewControllerDelegate {

    let item: Item
    
    init?(coder: NSCoder, item: Item) {
        self.item = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var PreviewButton: UIButton!
    @IBOutlet weak var BuyButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var CoverImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SubtitleLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var PublisherLabel: UILabel!
    @IBOutlet weak var PublishedDateLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var DescriptionScrollView: UIScrollView!
    @IBOutlet weak var MetadataView: UIVisualEffectView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        update()
        initBackgroundView()

    }
    
    //試讀
    @IBAction func previewBook(_ sender: Any) {
        if let urlStr = item.accessInfo.webReaderLink, let url = URL(string: urlStr) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            safariVC.dismissButtonStyle = .close
            safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    //購買
    @IBAction func buyBook(_ sender: Any) {
        if let urlStr = item.saleInfo.buyLink, let url = URL(string: urlStr) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.dismissButtonStyle = .close
            safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    
    //書目
    func update(){
        TitleLabel.text = item.volumeInfo.title
        SubtitleLabel.text = item.volumeInfo.subtitle
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
        DescriptionLabel.text = item.volumeInfo.description
        updateCover(item)
        adjustDescriptionView()
    }
    
    //書封
    func updateCover(_ item:Item){
        
        if let urlStr = item.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://"), let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url ) { data, response , error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.CoverImageView.image = UIImage(data: data)
                        self.BackgroundImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }else{
            self.CoverImageView.image = UIImage(named: "nocover")
            self.BackgroundImageView.image = UIImage(named: "nocover")
        }
    }
    
    //簡介
    func adjustDescriptionView(){
        if let wordCount = item.volumeInfo.description?.count {
            DescriptionScrollView.contentSize = CGSize(width: 0, height: wordCount + 70)
            DescriptionLabel.numberOfLines = wordCount / 10 + 50
            DescriptionLabel.sizeToFit()
        }
    }
    
    //背景
    func initBackgroundView(){
        BackgroundImageView.alpha = 0.5
        DescriptionScrollView.alpha = 0.5
        
        //封面
        CoverImageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        CoverImageView.layer.shadowOpacity = 0.5
        CoverImageView.layer.shadowRadius = 10
        CoverImageView.layer.shadowColor = UIColor.black.cgColor
        
        //書目介紹
        MetadataView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        MetadataView.layer.shadowOpacity = 0.5
        MetadataView.layer.shadowRadius = 10
        MetadataView.layer.shadowColor = UIColor.black.cgColor
        
        //按鈕
        if item.accessInfo.webReaderLink != nil {
            PreviewButton.isEnabled = true
        }else{
            PreviewButton.isEnabled = false
        }
        if item.saleInfo.buyLink != nil {
            BuyButton.isEnabled = true
        }else{
            BuyButton.isEnabled = false
        }
        
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
