//
//  ConnectImage.swift
//  HeroesSwift2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import Foundation
import UIKit

class ConnectImage{
    private var cacheList : [String : Data] = [:]
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: String, _ imageView: UIImageView) {
        let _url = URL(string: url)
        if self.cacheList[url] != nil{
            print("Used Cache")
            imageView.image = UIImage(data: self.cacheList[url]!)
        }else{
            print("Download Started")
            getData(from: _url!) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() {
                    self.cacheList[url] = data
                    imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func downloadImage(from url: String, _ imageView: UIImageView, _ completion : @escaping(_ complete : Bool)-> ()) {
        let _url = URL(string: url)
        if self.cacheList[url] != nil{
            print("Used Cache")
            imageView.image = UIImage(data: self.cacheList[url]!)
            completion(true)
        }else{
            print("Download Started")
            getData(from: _url!) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() {
                    self.cacheList[url] = data
                    imageView.image = UIImage(data: data)
                    completion(true)
                }
            }
        }
    }
}
