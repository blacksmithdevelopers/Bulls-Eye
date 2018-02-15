//
//  BEBearingMarker.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class BEBearingMark {
    var description: String = ""
    var radius: Double = 0.0
    var centerPoint: String = ""
    var degreesFromNinety: Int = 0
    var BEBearingMarkerName: String = ""
    var magVariation: Double = 0.0
    
    func inverseDegreesFromNinety() -> String {
        var inverse = self.degreesFromNinety - 90
        if inverse > 180 {
            inverse = inverse - 180
        } else {
            inverse = inverse + 180
        }
        let stringVerse = String(inverse)
        return stringVerse
    }
    
    
    func bearingMarkerCoordinateTranslate() -> [Double] {
        let bullsEyeCoords = self.centerPoint.coordTranslate()
        return bullsEyeCoords
        /*
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
        return bullsEyeCenterPoint
        */
    }
    
    
    func BEBearingMarkerGenerator() -> String {
        let degreesFromNinety = self.degreesFromNinety
        let radiusCalculated = self.radius * (1/60)
        let BEBearingMarkerName = self.BEBearingMarkerName//inverseDegreesFromNinety()
        let magVariation = self.magVariation
        
        let XptBearingMarker = ((radiusCalculated/cos(bearingMarkerCoordinateTranslate()[0] * Double.pi / 180)) * cos((Double(degreesFromNinety) + magVariation) * Double.pi / 180)) + bearingMarkerCoordinateTranslate()[1]
        let YptBearingMarker = (radiusCalculated * sin((Double(degreesFromNinety) + magVariation) * Double.pi / 180)) + bearingMarkerCoordinateTranslate()[0]
        let bullsEyeBearingLabel: String = "<Placemark><name>\(BEBearingMarkerName)'</name><description>\(description)</description><Point><coordinates>\(XptBearingMarker),\(YptBearingMarker),100</coordinates></Point></Placemark>"
        //print(bullsEyeBearingLabel)
        return bullsEyeBearingLabel
    }
}

