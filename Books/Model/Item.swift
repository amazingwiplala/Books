//
//  Item.swift
//  Books
//
//  Created by Jeanine Chuang on 2023/8/14.
//

import Foundation

struct ResultItem:Codable {
    let kind:String
    let totalItems:Int
    let items:[Item]
}

struct Item:Codable {
    let kind: String    //"books#volume"
    let id: String      //"TjYpEAAAQBAJ"
    let etag: String    //"XY3QVSRDgSM"
    let selfLink: String //"https://www.googleapis.com/books/v1/volumes/TjYpEAAAQBAJ"
    let volumeInfo: volumeInfo
    let saleInfo: saleInfo
    let accessInfo: accessInfo
}

struct volumeInfo:Codable {
    let title:String
    let subtitle:String?
    let authors:[String]?
    let publisher:String?
    let publishedDate:String?
    let description:String?
    var industryIdentifiers:[industryIdentify]? = [industryIdentify]()
    let categories:[String]?
    let imageLinks:imageLinks?
    let language:String
    let previewLink:String?
    let infoLink:String
    let canonicalVolumeLink:String
}

struct industryIdentify:Codable {
    let type: String        //"ISBN_13",
    let identifier: String  //"9789863487081"
}

struct imageLinks:Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct saleInfo:Codable {
    let country:String      //TW
    let saleability:String  //FOR_SALE
    let isEbook:Bool        //true
    let listPrice:price?
    let retailPrice:price?
    let buyLink:String?
}

struct price:Codable {
    let amount: Double
    let currencyCode: String    //TWD
}

struct accessInfo:Codable {
    let country:String
    let webReaderLink:String?
}

