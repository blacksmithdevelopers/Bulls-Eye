//
//  Variables.swift
//  KLM Maker
//
//  Created by elmo on 8/15/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation
//import UIKit

class Variables {
    
    //Bulls Eye Global Variables
    static var overlayFileName: String? = "BullsEye"
    static var BE_centerPoint: String? = "38.30943N/88.00854W"
    static var BE_centerPointCalculatedArray: [Double] = []
    static var BE_Name: String? = "xx BE NAME xx"
    static var BE_color: String = "Black"
    static var BE_opacity: String = "100"
    static var BE_width: Int = 5
    static var BE_styleName: String = "BE"
    static var BE_radiusOfOuterRing: Double = 200.0
    static var BE_magVariation: Double = 0.0
    static var BE_KML: String = ""
    
    static var UserMagVariation: Double = 0.0
    
    //Threat Global Variables
    static var GPSLattitude: Double = 0.0
    static var GPSLongitude: Double = 0.0
    static var UI_inputRange: Double = 0.0
    static var UI_inputBearing: Double = 0.0
    static var UI_threatName = "Threat"
    static var UI_threatColor = "Red"
    
    static var UI_popUpThreatRadius: Double = 10.0
    static var UI_popUpThreatLocation: [Double] = [0.0, 0.0]
    
    static var POI_latitude: Double = 0.0
    static var POI_longitude: Double = 0.0
    static var POI_currentDistanceFromDevice: Double = 0.0
    static var POI_currentHeadingFromDevice: Double = 0.0
    static var POI_rangeFromBE: Double = 0.0
    static var POI_bearingFromBE: Double = 0.0

    
    
    
    
}


// MARK: Define Keys for User Defaults
extension DefaultsKeys {
    //Bulls Eye Global Variable Defaults
    static let overlayFileName = DefaultsKey<String?>("overlayFileName")
    static let BE_centerPoint = DefaultsKey<String?>("BE_centerPoint")
    static let BE_centerPointCalculatedArray = DefaultsKey<[Double]>("BE_centerPointCalculatedArray")
    static let BE_Name = DefaultsKey<String?>("BE_Name")
    static let BE_color = DefaultsKey<String>("BE_color")
    static let BE_opacity = DefaultsKey<String>("BE_opacity")
    static let BE_width = DefaultsKey<Int>("BE_width")
    static let BE_styleName = DefaultsKey<String>("BE_styleName")
    static let BE_radiusOfOuterRing = DefaultsKey<Double>("BE_radiusOfOuterRing")
    static let BE_magVariation = DefaultsKey<Double>("BE_magVariation")
    static let BE_KML = DefaultsKey<String>("BE_KML")
    
    static let UserMagVariation = DefaultsKey<Double>("UserMagVariation")
    
    //Threat Global Variables
    static let GPSLattitude = DefaultsKey<Double>("GPSLattitude")
    static let GPSLongitude = DefaultsKey<Double>("GPSLongitude")
    static let UI_inputRange = DefaultsKey<Double>("UI_inputRange")
    static let UI_inputBearing = DefaultsKey<Double>("UI_inputBearing")
    static let UI_threatName = DefaultsKey<String>("UI_threatName")
    static let UI_threatColor = DefaultsKey<String>("UI_threatColor")
    
    static let UI_popUpThreatRadius = DefaultsKey<Double>("UI_popUpThreatRadius")
    static let UI_popUpThreatLocation = DefaultsKey<[Double]>("UI_popUpThreatLocation")
    
    static let POI_latitude = DefaultsKey<Double>("POI_latitude")
    static let POI_longitude = DefaultsKey<Double>("POI_longitude")
    static let POI_currentDistanceFromDevice = DefaultsKey<Double>("POI_currentDistanceFromDevice")
    static let POI_currentHeadingFromDevice = DefaultsKey<Double>("POI_currentHeadingFromDevice")
    static let POI_rangeFromBE = DefaultsKey<Double>("POI_rangeFromBE")
    static let POI_bearingFromBE = DefaultsKey<Double>("POI_bearingFromBE")
}




































