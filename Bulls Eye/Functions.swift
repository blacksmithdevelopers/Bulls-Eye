//
//  Functions.swift
//  Bulls Eye
//
//  Created by elmo on 2/19/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import Foundation


class Functions {
    public func rangeAndBearing(latitude_01: Double, longitude_01: Double, latitude_02: Double, longitude_02: Double) -> [Double] {
        let majEarthAxis_WGS84: Double = 6_378_137.0                // maj      - meters
        let minEarthAxis_WGS84: Double = 6_356_752.314_245          // min      - meters
        let lat_01 = latitude_01.degreesToRadians
        let lat_02 = latitude_02.degreesToRadians
        let long_01 = longitude_01.degreesToRadians
        let long_02 = longitude_02.degreesToRadians
        let difLong = (longitude_02 - longitude_01).degreesToRadians
        //1: radiusCorrectionFactor()
        let a1 = 1.0/(majEarthAxis_WGS84 * majEarthAxis_WGS84)
        let b1 = (tan(lat_01) * tan(lat_01)) / (minEarthAxis_WGS84 * minEarthAxis_WGS84)
        let c1 = 1.0/((a1+b1).squareRoot())
        let d1 = c1/(cos(lat_01))
        //2: Law of Cosines
        let range = (acos(sin(lat_01)*sin(lat_02) + cos(lat_01)*cos(lat_02) * cos(difLong)) * d1).metersToNauticalMiles
        //3: Calculating Bearing from 1st coords to second
        let a3 = sin(long_02 - long_01) * cos(lat_02)
        let b3 = cos(lat_01) * sin(lat_02) - sin(lat_01) * cos(lat_02) * cos(long_02 - long_01)
        let bearing = atan2(a3, b3).radiansToDegrees
        let results = [range, bearing]
        print(range)
        return results
    }
}

