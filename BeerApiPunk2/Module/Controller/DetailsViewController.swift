//
//  DetailsViewController.swift
//  BeerApiPunk2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var choiseBeer : Beer?
    var downloadImage : ConnectImage!
    
    var mainView: DetailBeerView{
        get{
            return self.view as! DetailBeerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        downloadImage = ConnectImage()
        
        prepareView()
        
    }
    
    func prepareView(){
        if choiseBeer != nil{
            self.mainView.NomeBebidaLabel.text     = choiseBeer?.name
            self.mainView.TagLineLabel.text     = choiseBeer?.tagline
            self.mainView.DescLabel.text = choiseBeer?.description
            self.mainView.AmarguraLabel.text         = choiseBeer?.ibu.toString()
            self.mainView.PercAlcoolLabel.text         = "\((choiseBeer?.abv)!) %vol"
            self.downloadImage.downloadImage(from: (choiseBeer?.img)! , self.mainView.DetailImageView)
            
        }
        
    }
}
