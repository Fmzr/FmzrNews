//
//  Article.swift
//  FmzrNews
//
//  Created by Irfandi Kurniawan Anwar on 29/08/23.
//

import Foundation



struct Results: Decodable {
    
    let results: [Article]
}

struct Article: Decodable, Identifiable{
 
    let id: Int
    let title: String
    let url: String?
    let image_url: String?
    let summary: String
    let news_site: String
    
    var imageURL: URL? {
        guard let image_url = image_url else {
            return nil
        }
        return URL(string: image_url)
    }
    
    var siteURL: URL? {
        guard let url = url else {
            return nil
        }
        return URL(string: url)
    }
    
   
    
    
   
}

