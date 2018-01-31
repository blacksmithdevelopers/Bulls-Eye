//
//  BEDistanceMarker.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class BEDistanceMarker {
    var BEDistanceMarkerName: String = ""
    var centerPoint: String = ""
    var radius: Double = 0.0
    var description: String = ""
    var magVariation: Double = 0.0
    
    
    func distanceMarkerCoordinateTranslate() -> [Double] {
        let bullsEyeCoords = self.centerPoint
        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
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
        //print(bullsEyeCenterPoint)
        return bullsEyeCenterPoint
    }
    
    
    func BEDistanceMarkerGenerator() -> String {
        let radiusCalculated = self.radius * (1/60)
        let bullsEyeDistance = self.BEDistanceMarkerName
        let description = self.description
        let magVariation = self.magVariation
        let XptDistanceMarker = ((radiusCalculated/cos(distanceMarkerCoordinateTranslate()[0] * Double.pi / 180)) * cos((360 + magVariation) * Double.pi / 180)) + distanceMarkerCoordinateTranslate()[1]
        let YptDistanceMarker = (radiusCalculated * sin((360 + magVariation) * Double.pi / 180)) + distanceMarkerCoordinateTranslate()[0]
        let bullsEyeDistanceLabel: String = "<Placemark><name>\(bullsEyeDistance)NM</name><description>\(description)</description><Point><coordinates>\(XptDistanceMarker),\(YptDistanceMarker),100</coordinates></Point></Placemark>"
        
        return bullsEyeDistanceLabel
        
    }
    
    
}

