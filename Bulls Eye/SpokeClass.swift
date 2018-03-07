//
//  LineClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class Spoke {
    var name: String = ""
    var description: String = ""
    var extrude: String = "1"
    var tessellate: String = ""
    var altMode: String = "absolute"
    var styleName: String = ""
    var radius: Double = 0.0
    var centerPoint: String = ""
    var degreesFromNinety: Double = 0.0
    var magVariation: Double = 0.0
    
    func inverseDegreesFromNinety() -> Double {
        var inverse = self.degreesFromNinety
        if inverse > 180 {
            inverse = inverse - 180
        } else {
            inverse = inverse + 180
        }
        return inverse
    }
    
    func spokeCoordinateTranslate() -> [Double] {
        let bullsEyeCoords = self.centerPoint.coordTranslate()
        return bullsEyeCoords
    }
    
    
    
    func spokeGenerator() -> String {
        let styleName = self.styleName
        let radiusCalculated = self.radius * (1/60)
        let magVariation = self.magVariation
        
        let Xpt_1 = ((radiusCalculated/cos(spokeCoordinateTranslate()[0] * Double.pi / 180)) * cos((degreesFromNinety + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[1]
        let Ypt_1 = (radiusCalculated * sin((degreesFromNinety + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[0]
        let Xpt_2 = ((radiusCalculated/cos(spokeCoordinateTranslate()[0] * Double.pi / 180)) * cos((inverseDegreesFromNinety() + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[1]
        let Ypt_2 = (radiusCalculated * sin((inverseDegreesFromNinety() + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[0]
        
        let point_1 = "\(Xpt_1),\(Ypt_1),500"
        let centerPoint = "\(spokeCoordinateTranslate()[1]),\(spokeCoordinateTranslate()[0]),500"
        let point_2 = "\(Xpt_2),\(Ypt_2),500"
        
        let spoke: String = "<Placemark><name>\(name)</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(point_1)\r\(centerPoint)\r\(point_2)\r</coordinates></LineString></Placemark>"
        //print(spoke)
        return spoke
    }
    
}
