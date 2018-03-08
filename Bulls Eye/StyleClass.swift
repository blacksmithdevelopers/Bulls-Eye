//
//  StyleClass.swift
//  KLM Maker
//
//  Created by elmo on 7/27/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import Foundation

class Style {
    var name: String = ""
    var color: String = ""
    var opacity: String = "100"
    var width: Int = 8
    
    func styleGenerator() -> String {
        let name = self.name
        let color = self.color
        let opacity = self.opacity
        let lineWidth = self.width
        var colorDictionary = ["Black"         : "000000",
                               "Red"           : "1400FF",
                               "Orange"        : "1478FF",
                               "Dark Yellow"   : "14B4FF",
                               "Yellow"        : "14F0FF",
                               "Dark Green"    : "147800",
                               "Light green"   : "14F000",
                               "Dark Blue"     : "780014"]
        var transparencyPercentage = [  "0"   : "0",
                                        "5"   : "5",
                                        "10"  : "a",
                                        "15"  : "f",
                                        "20"  : "14",
                                        "25"  : "19",
                                        "30"  : "1e",
                                        "35"  : "23",
                                        "40"  : "28",
                                        "45"  : "2d",
                                        "50"  : "32",
                                        "55"  : "37",
                                        "60"  : "3c",
                                        "65"  : "41",
                                        "70"  : "46",
                                        "75"  : "4b",
                                        "80"  : "50",
                                        "85"  : "55",
                                        "90"  : "5a",
                                        "95"  : "5f",
                                        "100" : "ff"]
        let lineStyleColor = (transparencyPercentage[opacity]! + colorDictionary[color]!)
        let style: String = "<Style id=\"\(name)\"><LineStyle><color>\(lineStyleColor)</color><width>\(lineWidth)</width></LineStyle><PolyStyle><color>\(lineStyleColor)</color></PolyStyle></Style>" //<name>\(name)</name><description></description>"
        //print(style)
        return style
    }
    
}
