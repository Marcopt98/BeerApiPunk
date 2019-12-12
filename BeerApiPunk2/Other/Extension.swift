//
//  Extension.swift
//  BeerApiPunk2
//
//  Created by itsector on 14/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

import Foundation

extension String{
    func getUrlPage(_ page : String) -> String{
        return self.replacingOccurrences(of: "{p}", with: page)
    }
    
}
extension Int{
    func toString() ->String{
        return"\(self)"
    }
}
extension Double{
    func toString() ->String{
        return"\(self)"
    }
}
