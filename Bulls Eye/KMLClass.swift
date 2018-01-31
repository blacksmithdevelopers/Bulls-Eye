//
//  KMLClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class KML {
    var openingKML: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><kml xmlns=\"http://www.opengis.net/kml/2.2\"><Document>"
    var closingKML: String = "</Document></kml>"
    //var generatedKMLfromOtherClasses: String = ""
    
    func KMLGenerator(_ generatedKMLfromOtherClasses: String) -> String {
        let openingKML = self.openingKML
        let closingKML = self.closingKML
        let generatedKMLfromOtherClasses = generatedKMLfromOtherClasses
        let KML: String = "\(openingKML)\(generatedKMLfromOtherClasses)\(closingKML)"
        //print(KML)
        return KML
    }
    
}
