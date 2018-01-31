//
//  ThreatClass.swift
//  KLM Maker
//
//  Created by elmo on 8/13/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation


class Threat: Circle {
    var GPSLattitude: Double = 0.0
    var GPSLongitude: Double = 0.0
    var userInputRange: Double = 0.0
    var userInputBearing: Double = 0.0
    var bullsEyeMagVariation: Double = 0.0
    var threatName = "Threat"
    var threatColor = "Red"
    var threatLabel = PlaceMark()
    var threatCircleMarker = Circle()
    var threatStyle = Style()
    
    func threatCoordCalculation() -> [Double]{
        let GPSLattitude = self.GPSLattitude
        let GPSLongitude = self.GPSLongitude
        let userInputRange = self.userInputRange
        var userInputBearing = self.userInputBearing
        if userInputBearing > 180 {
            userInputBearing -= 180
        } else {
            userInputBearing += 180
        }
        
        let magVariation = self.bullsEyeMagVariation
        let radiusCalculated = userInputRange/60
        let theta = 270 - userInputBearing
        let x = (radiusCalculated/(cos(GPSLattitude*(Double.pi/180)))*(cos(((theta+magVariation)*Double.pi)/180)))+GPSLongitude
        let y = (radiusCalculated*sin((theta+magVariation)*Double.pi/180))+GPSLattitude
        let coords = [y,x]
        return(coords)
    }
    
    func distanceCalculator(_ bullsEyeCoords: [Double]) -> Double {
        let bullsEyeCoords = bullsEyeCoords
        let threatCoords = threatCoordCalculation()
        let X1 = (threatCoords[0]*(Double.pi/180))
        let X2 = (bullsEyeCoords[0]*(Double.pi/180))
        let Y1 = (threatCoords[1]*(Double.pi/180))
        let Y2 = (bullsEyeCoords[1]*(Double.pi/180))
        let radiusOfEarth = 3440.0
        let distanceFromTheBullsEye = radiusOfEarth*acos((sin(X1)*sin(X2)+cos(X1)*cos(X2)*cos(Y1-Y2)))
        return distanceFromTheBullsEye
    }
    
    func bearingCalculator(_ bullsEyeCoords: [Double]) -> Double {
        let bullsEyeCoords = bullsEyeCoords
        let threatCoords = threatCoordCalculation()
        let X2 = (threatCoords[0]*(Double.pi/180))
        let X1 = (bullsEyeCoords[0]*(Double.pi/180))
        let Y2 = (threatCoords[1]*(Double.pi/180))
        let Y1 = (bullsEyeCoords[1]*(Double.pi/180))
        let x = sin(abs(Y1-Y2))*cos(X1)
        let y = (cos(X1)*sin(X2))-(sin(X1)*cos(X2)*cos(abs(Y1-Y2)))
        let bearingFromTheBullsEye =  (atan2(x, y))*(180/Double.pi)
        return bearingFromTheBullsEye
        
    }
    
    
    func threatPlot() -> String {
        threatLabel.placeMarkCalculatedCoords = threatCoordCalculation()
        threatLabel.placeMarkTitle = threatName
        let threatLabelKML = threatLabel.placeMarkGeneratorWithCalculatedCoords()
        threatCircleMarker.centerPointCalculated = threatCoordCalculation()
        threatCircleMarker.radius = 2.5
        threatCircleMarker.styleName = threatName
        let threatCircleMarkerKML =  threatCircleMarker.circleGeneratorFromCalculatedCoords()
        threatStyle.color = threatColor
        threatStyle.name = threatName
        threatStyle.opacity = "100"
        threatStyle.width = 30
        let threatStyleKML = threatStyle.styleGenerator()
        let threatKML = "\(threatStyleKML)\(threatLabelKML)\(threatCircleMarkerKML)"
        return threatKML
    }
}

