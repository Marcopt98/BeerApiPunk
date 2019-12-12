//
//  Product.swift
//  BeerApiPunk2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import Foundation
import UIKit

class Beer: Codable {
    var name        : String = ""
    var img         : String = ""
    var abv         : Double = 0.0
    var tagline     : String = ""
    var ibu         : Double = 0.0
    var description : String = ""
    var page         : String = ""
    
    
    func getProductions(_ completion: @escaping([Beer])-> ()){
        let url = BASEURL.getUrlPage(self.page)
        Connection.getProduct(url) { (success) in
            if success != nil {
                completion(success)
            }else{
                let prods :[Beer] = []
                completion(prods)
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case img = "image_url"
        case description = "description"
        case abv = "abv"
        case tagline = "tagline"
        //case ibu = "ibu"
    }
    
    
}
