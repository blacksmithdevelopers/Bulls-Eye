//
//  PlaceMarkClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class PlaceMark {
    var placeMarkTitle: String = ""
    var placeMarkDescription: String = ""
    var placeMarkCoords: String = ""
    var placeMarkCalculatedCoords: [Double] = []
    var placeMarkPOICoords = [String]()
    
    func placeMarkCoordinateTranslate() -> [Double] {
        let placeMarkCoords = self.placeMarkCoords.coordTranslate()
        return placeMarkCoords
        /*
        let placeMarkCoordsInt = self.placeMarkCoords
        var coordsArray = placeMarkCoordsInt.components(separatedBy: "/")
        var lattitude: Double = 0.0
        var longitude = 0.0
        if coordsArray[0].range(of: "N") != nil {
            let lattitudeString = String(coordsArray[0].dropLast())
            lattitude = Double(lattitudeString)!
        } else {
            let lattitudeString = String(coordsArray[0].dropLast())
            lattitude = -1 * Double(lattitudeString)!
        }
        if coordsArray[1].range(of: "W") != nil {
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = -1 * Double(longitudeString)!
        } else {
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = Double(longitudeString)!
        }
        let bullsEyeCenterPoint: Array = [lattitude,longitude]
        return bullsEyeCenterPoint
        */
    }
    
    func placeMarkGeneratorWithCalculatedCoords() -> String {
        let placeMarkCalculatedCoords = self.placeMarkCalculatedCoords
        let placeMarkKML: String = "<Placemark><name>\(placeMarkTitle)</name><description>\(placeMarkDescription)</description><Point><coordinates>\(placeMarkCalculatedCoords[1]),\(placeMarkCalculatedCoords[0]),500</coordinates></Point></Placemark>"
        return placeMarkKML
    }
    
    func placeMarkGeneratorWithPreCalcCoords() -> String {
        let placeMarkKML: String = "<Placemark><name>\(placeMarkTitle)</name><description>\(placeMarkDescription)</description><Point><coordinates>\(placeMarkPOICoords[0]),\(placeMarkPOICoords[1]),500</coordinates></Point></Placemark>"
        return placeMarkKML
    }
    
    func placeMarkGenerator() -> String {
        let placeMarkKML: String = "<Placemark><name>\(placeMarkTitle)</name><description>\(placeMarkDescription)</description><Point><coordinates>\(placeMarkCoordinateTranslate()[1]),\(placeMarkCoordinateTranslate()[0]),500</coordinates></Point></Placemark>"
        return placeMarkKML
    }
}
