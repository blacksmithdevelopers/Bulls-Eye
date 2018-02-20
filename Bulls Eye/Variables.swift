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




































