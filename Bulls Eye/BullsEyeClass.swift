//
//  BullsEyeClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//
import Foundation

class BullsEye {

    
    func bullsEye() -> String {
        
        let bullsEyeName = Variables.BE_Name
        let color = Variables.BE_color
        let opacity = Variables.BE_opacity
        let width = Variables.BE_width
        let centerPoint = Variables.BE_centerPoint
        let radiusOfOuterRing = Variables.BE_radiusOfOuterRing
        let styleName = Variables.BE_styleName
        let magVariation = Variables.BE_magVariation * -1
        
        let bullsEyeStyle = Style()
        bullsEyeStyle.color = color
        bullsEyeStyle.name = styleName
        bullsEyeStyle.opacity = opacity
        bullsEyeStyle.width = width
        let style1 = bullsEyeStyle.styleGenerator()
        
        let bullsEyeNameMarker = PlaceMark()
        bullsEyeNameMarker.placeMarkTitle = bullsEyeName!
        bullsEyeNameMarker.placeMarkCoords = centerPoint!
        let BEName = bullsEyeNameMarker.placeMarkGenerator()
        
        let distanceMarker_01 = BEDistanceMarker()
        distanceMarker_01.centerPoint = centerPoint!
        distanceMarker_01.radius = (radiusOfOuterRing/6)*2
        distanceMarker_01.BEDistanceMarkerName = String(Int(distanceMarker_01.radius))
        distanceMarker_01.magVariation = magVariation
        let DM_01 = distanceMarker_01.BEDistanceMarkerGenerator()
        
        let distanceMarker_02 = BEDistanceMarker()
        distanceMarker_02.centerPoint = centerPoint!
        distanceMarker_02.radius = (radiusOfOuterRing/6)*4
        distanceMarker_02.BEDistanceMarkerName = String(Int(distanceMarker_02.radius))
        distanceMarker_02.magVariation = magVariation
        let DM_02 = distanceMarker_02.BEDistanceMarkerGenerator()
        
        let bearingMarker_01 = BEBearingMark()
        bearingMarker_01.BEBearingMarkerName = "\(String(Int(radiusOfOuterRing)))-90"
        bearingMarker_01.centerPoint = centerPoint!
        bearingMarker_01.degreesFromNinety = 0
        bearingMarker_01.magVariation = magVariation
        bearingMarker_01.description = ""
        bearingMarker_01.radius = radiusOfOuterRing
        let BE_01 = bearingMarker_01.BEBearingMarkerGenerator()
        
        let bearingMarker_02 = BEBearingMark()
        bearingMarker_02.BEBearingMarkerName = "45"
        bearingMarker_02.centerPoint = centerPoint!
        bearingMarker_02.degreesFromNinety = 45
        bearingMarker_02.magVariation = magVariation
        bearingMarker_02.description = ""
        bearingMarker_02.radius = radiusOfOuterRing
        let BE_02 = bearingMarker_02.BEBearingMarkerGenerator()
        
        let bearingMarker_03 = BEBearingMark()
        bearingMarker_03.BEBearingMarkerName = "360"
        bearingMarker_03.centerPoint = centerPoint!
        bearingMarker_03.degreesFromNinety = 90
        bearingMarker_03.magVariation = magVariation
        bearingMarker_03.description = ""
        bearingMarker_03.radius = radiusOfOuterRing
        let BE_03 = bearingMarker_03.BEBearingMarkerGenerator()
        
        let bearingMarker_04 = BEBearingMark()
        bearingMarker_04.BEBearingMarkerName = "315"
        bearingMarker_04.centerPoint = centerPoint!
        bearingMarker_04.degreesFromNinety = 135
        bearingMarker_04.magVariation = magVariation
        bearingMarker_04.description = ""
        bearingMarker_04.radius = radiusOfOuterRing
        let BE_04 = bearingMarker_04.BEBearingMarkerGenerator()
        
        let bearingMarker_05 = BEBearingMark()
        bearingMarker_05.BEBearingMarkerName = "270"
        bearingMarker_05.centerPoint = centerPoint!
        bearingMarker_05.degreesFromNinety = 180
        bearingMarker_05.magVariation = magVariation
        bearingMarker_05.description = ""
        bearingMarker_05.radius = radiusOfOuterRing
        let BE_05 = bearingMarker_05.BEBearingMarkerGenerator()
        
        let bearingMarker_06 = BEBearingMark()
        bearingMarker_06.BEBearingMarkerName = "225"
        bearingMarker_06.centerPoint = centerPoint!
        bearingMarker_06.degreesFromNinety = 225
        bearingMarker_06.magVariation = magVariation
        bearingMarker_06.description = ""
        bearingMarker_06.radius = radiusOfOuterRing
        let BE_06 = bearingMarker_06.BEBearingMarkerGenerator()
        
        let bearingMarker_07 = BEBearingMark()
        bearingMarker_07.BEBearingMarkerName = "180"
        bearingMarker_07.centerPoint = centerPoint!
        bearingMarker_07.degreesFromNinety = 270
        bearingMarker_07.magVariation = magVariation
        bearingMarker_07.description = ""
        bearingMarker_07.radius = radiusOfOuterRing
        let BE_07 = bearingMarker_07.BEBearingMarkerGenerator()
        
        let bearingMarker_08 = BEBearingMark()
        bearingMarker_08.BEBearingMarkerName = "135"
        bearingMarker_08.centerPoint = centerPoint!
        bearingMarker_08.degreesFromNinety = 315
        bearingMarker_08.magVariation = magVariation
        bearingMarker_08.description = ""
        bearingMarker_08.radius = radiusOfOuterRing
        let BE_08 = bearingMarker_08.BEBearingMarkerGenerator()
        
        let circle_01 = Circle()
        circle_01.styleName = styleName
        circle_01.radius = radiusOfOuterRing/6
        circle_01.centerPoint = centerPoint!
        let c1 = circle_01.circleGenerator()
        
        let circle_02 = Circle()
        circle_02.styleName = styleName
        circle_02.radius = (radiusOfOuterRing/6)*2
        circle_02.centerPoint = centerPoint!
        let c2 = circle_02.circleGenerator()
        
        let circle_03 = Circle()
        circle_03.styleName = styleName
        circle_03.radius = (radiusOfOuterRing/6)*3
        circle_03.centerPoint = centerPoint!
        let c3 = circle_03.circleGenerator()
        
        let circle_04 = Circle()
        circle_04.styleName = styleName
        circle_04.radius = (radiusOfOuterRing/6)*4
        circle_04.centerPoint = centerPoint!
        let c4 = circle_04.circleGenerator()
        
        let circle_05 = Circle()
        circle_05.styleName = styleName
        circle_05.radius = (radiusOfOuterRing/6)*5
        circle_05.centerPoint = centerPoint!
        let c5 = circle_05.circleGenerator()
        
        let circle_06 = Circle()
        circle_06.styleName = styleName
        circle_06.radius = (radiusOfOuterRing/6)*6
        circle_06.centerPoint = centerPoint!
        let c6 = circle_06.circleGenerator()
        
        let spoke_01 = Spoke()
        spoke_01.centerPoint = centerPoint!
        spoke_01.degreesFromNinety = 0.0
        spoke_01.styleName = styleName
        spoke_01.radius = radiusOfOuterRing
        spoke_01.magVariation = magVariation
        let s1 = spoke_01.spokeGenerator()
        
        let spoke_02 = Spoke()
        spoke_02.centerPoint = centerPoint!
        spoke_02.degreesFromNinety = 45.0
        spoke_02.styleName = styleName
        spoke_02.radius = radiusOfOuterRing
        spoke_02.magVariation = magVariation
        let s2 = spoke_02.spokeGenerator()
        
        let spoke_03 = Spoke()
        spoke_03.centerPoint = centerPoint!
        spoke_03.degreesFromNinety = 90.0
        spoke_03.styleName = styleName
        spoke_03.radius = radiusOfOuterRing
        spoke_03.magVariation = magVariation
        let s3 = spoke_03.spokeGenerator()
        
        let spoke_04 = Spoke()
        spoke_04.centerPoint = centerPoint!
        spoke_04.degreesFromNinety = 135.0
        spoke_04.styleName = styleName
        spoke_04.radius = radiusOfOuterRing
        spoke_04.magVariation = magVariation
        let s4 = spoke_04.spokeGenerator()
        
        let internalKML: String = "\(style1)\(BEName)\(DM_01)\(DM_02)\(BE_01)\(BE_02)\(BE_03)\(BE_04)\(BE_05)\(BE_06)\(BE_07)\(BE_08)\(s1)\(s2)\(s3)\(s4)\(c1)\(c2)\(c3)\(c4)\(c5)\(c6)"

        return internalKML
    }
}

