//
//  CircleClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class Circle {
    var styleName: String = ""
    var description: String = ""
    var extrude: String = "1"
    var tessellate: String = "1"
    var altMode: String = "absolute"
    var radius: Double = 0.0
    var centerPoint: String = ""
    var centerPointCalculated: [Double] = []
    //var magneticVariation: Double = 0.0
    var centerLabelTitle: String = ""
    var centerLabelDescription: String = ""
    
    func bullsEyeCoordinateTranslate() -> [Double] {
        let bullsEyeCoords = self.centerPoint.coordTranslate()
        return bullsEyeCoords
    }
    
    func circleGeneratorFromCalculatedCoords () -> String {
        let styleName = self.styleName
        //let magVar = self.magneticVariation
        let lattitude = centerPointCalculated[0]
        let longitude = centerPointCalculated[1]
        let radiusCalculated = self.radius * (1/60)
        var circleOrderedPairs: [String] = []
        var coordPairs: String = ""
        
        for i in 0 ..< 365 {
            let j = Double(i)
            let x = ((radiusCalculated/cos(lattitude * Double.pi / 180)) * cos(j * Double.pi / 180)) + longitude
            let y = (radiusCalculated * sin(j * Double.pi / 180)) + lattitude
            let Xcoord = String(x)
            let Ycoord = String(y)
            
            let coordinates = "\(Xcoord),\(Ycoord)"
            circleOrderedPairs.append(coordinates)
        }
        
        for pair in circleOrderedPairs {
            coordPairs += "\(pair),500\r"
        }
        
        let circleKML: String = "<Placemark><name>\(String(radiusCalculated))</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(coordPairs)</coordinates></LineString></Placemark>"
        //print(circleKML)
        return (circleKML)
        
    }
    
    func circleGenerator () -> String {
        let styleName = self.styleName
        //let magVar = self.magneticVariation
        let lattitude = bullsEyeCoordinateTranslate()[0]
        let longitude = bullsEyeCoordinateTranslate()[1]
        let radiusCalculated = self.radius * (1/60)
        var circleOrderedPairs: [String] = []
        var coordPairs: String = ""
        
        for i in 0 ..< 361 {
            let j = Double(i)
            let x = ((radiusCalculated/cos(lattitude * Double.pi / 180)) * cos(j * Double.pi / 180)) + longitude
            let y = (radiusCalculated * sin(j * Double.pi / 180)) + lattitude
            let Xcoord = String(x)
            let Ycoord = String(y)
            
            let coordinates = "\(Xcoord),\(Ycoord)"
            circleOrderedPairs.append(coordinates)
        }
        
        for pair in circleOrderedPairs {
            coordPairs += "\(pair),500\r"
        }
        
        let circleKML: String = "<Placemark><name>\(String(radiusCalculated))</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(coordPairs)</coordinates></LineString></Placemark>"
        //print(circleKML)
        return (circleKML)
        
    }
    func circleCenterLabelGenerator() -> String {
        
        let canterLabelKML: String = "<Placemark><name>\(centerLabelTitle)</name><description>\(centerLabelDescription)</description><Point><coordinates>\(bullsEyeCoordinateTranslate()[1]),\(bullsEyeCoordinateTranslate()[0]),500</coordinates></Point></Placemark>"
        //print(placeMarkKML)
        return canterLabelKML
    }
    
}
