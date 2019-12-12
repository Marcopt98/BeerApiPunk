//
//  Connect.swift
//  HeroesSwift2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import Foundation

class Connection /*<T:Codable>*/{
    
    class func getProduct(_ theURL:String, _ completion : @escaping([Beer])->()){
        let url            = URL(string: theURL)
        var request        = URLRequest(url: url!)
        request.httpMethod = "GET"
        let http           = URLSession.shared
        let data           = http.dataTask(with: url!) { (data, res, erro) in
            
            if erro == nil{
                print(String(data: data!, encoding: String.Encoding.utf8))
                do{
                    //let type : T.Type = T.self
                    let beers =  try JSONDecoder().decode([Beer].self, from: data!)
                    
                    completion(beers)
                    
                } catch{
                    print("ERRO")
                }
                
                
            }
        }
        data.resume()
        
        
//        let data2 = http.dataTask(with: request) { (data, res, erro) in
//            if erro == nil{
//                print(String(data: data!, encoding: String.Encoding.utf8))
//                do{
//                    let type : T.Type = T.self
//                    let heroes : T  =  try JSONDecoder().decode(type, from: data!)
//                    print("AQUI")
//                    completion(heroes)
//
//                } catch{
//                    print("ERRO")
//                }
//
//
//            }
//        }
        //data2.resume()
        
        
    }
    
}
