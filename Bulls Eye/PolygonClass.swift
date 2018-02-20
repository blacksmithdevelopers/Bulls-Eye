//
//  PolygonClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class PolygonClass {
    var foreFlightCoords: String = ""
    var name: String = ""
    var styleName: String = ""
    var description: String = ""
    var extrude: String = "1"
    var tessellate: String = "1"
    var altMode: String = "absolute"
    
    func FFProcessor() -> String {
        let foreFlightCoords = self.foreFlightCoords
        var foreFlightCoordsP = foreFlightCoords.components(separatedBy: " ")
        let coordsSetCount = foreFlightCoordsP.count - 1
        foreFlightCoordsP.remove(at: coordsSetCount)
        //var coords: Array<Double> = []
        var coordString: String = ""
        for coordPairs in foreFlightCoordsP {
            let new = String(describing: CoordinateTranslate(coordPairs))
            coordString += "\(new),500\r"//CoordinateTranslate(coordPairs)
            
        }
        coordString = coordString.replacingOccurrences(of: "[", with: " ")
        coordString = coordString.replacingOccurrences(of: "]", with: " ")
        //print(coordString)
        return coordString
    }
    
    func CoordinateTranslate(_ coords: String) -> [Double] {
        let bullsEyeCoords = coords
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
            //print("West")
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = -1 * Double(longitudeString)!
        } else {
            //print("East")
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = Double(longitudeString)!
        }
        let bullsEyeCenterPoint: Array = [longitude,lattitude]
        //print(bullsEyeCenterPoint)
        return bullsEyeCenterPoint
    }
    
    func polygonGenerator() -> String {
        let styleName = self.styleName
        let name = self.name
        let extrude = self.extrude
        let tessellate = self.tessellate
        let altMode = self.altMode
        let points = "\(FFProcessor())"
        let polygon: String = "<Placemark><name>\(name)</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(points)\r</coordinates></LineString></Placemark>"
        return polygon
    }
    
    func foreFlightPolygonGenerator(_ points: String) -> String {
        let styleName = self.styleName
        let name = self.name
        let extrude = self.extrude
        let tessellate = self.tessellate
        let altMode = self.altMode
        let polygon: String = "<Placemark><name>\(name)</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(points)\r</coordinates></LineString></Placemark>"
        return polygon
    }
}

