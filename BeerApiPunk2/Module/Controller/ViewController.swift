//
//  ViewController.swift
//  BeerApiPunk2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var beer : Beer?
    var beers : [Beer] = []
    var downloadImage : ConnectImage!
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0
    var didEndReached:Bool=false
    
    var mainView : MainBeerView{
        get {
            return self.view as! MainBeerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mainView.indicatorActivity.hidesWhenStopped = true
        
        self.mainView.tableView.delegate   = self
        self.mainView.tableView.dataSource = self
        
        downloadImage = ConnectImage()
        beer = Beer()
        beer?.page = pageNo.toString()
        
        self.mainView.indicatorActivity.startAnimating()
        
        beer?.getProductions({ (beerList) in
            self.beers = beerList
            
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
                self.mainView.indicatorActivity.stopAnimating()
            }
        })
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender != nil {
            let viewController = segue.destination as! DetailsViewController
            viewController.choiseBeer = sender as? Beer
        }
    }

}



extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostumCell") as! BeerTableViewCell
        cell.BeerNameLabel.text = beers[indexPath.row].name
        cell.BeerAlcoolLabel.text  = "Teor de Alcool \(beers[indexPath.row].abv) %vol"
        
        self.downloadImage.downloadImage(from: beers[indexPath.row].img , cell.BeerImageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "productsToDetail", sender: beers[indexPath.row])
    }
    
    
}


//-MARK: Métodos para o Scroll
extension ViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((mainView.tableView.contentOffset.y + mainView.tableView.frame.size.height) >= mainView.tableView.contentSize.height)
        {
            if !isDataLoading{
                
                self.mainView.indicatorActivity.startAnimating()
                isDataLoading = true
                self.pageNo=self.pageNo + 1
                self.limit=self.limit + 10
                self.offset=self.limit * self.pageNo
                beer?.page = self.pageNo.toString()
                beer?.getProductions({ (produtionsResult) in
                    self.beers.append(contentsOf: produtionsResult)
                    DispatchQueue.main.async {
                        self.mainView.tableView.reloadData()
                        self.mainView.indicatorActivity.stopAnimating()
                    }
                })
                
            }
        }
        
    }
    
    
}

