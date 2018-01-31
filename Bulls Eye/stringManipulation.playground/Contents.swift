//: Playground - noun: a place where people can play

import UIKit



//var FF: String = "43.97616N/122.3671W 43.21964N/122.91481W 42.57137N/121.40641W 44.22678N/120.08235W 44.46008N/121.84025W 60000ft"
//
//class KML {
//    var openingKML: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><kml xmlns=\"http://www.opengis.net/kml/2.2\"><Document>"
//    var closingKML: String = "</Document></kml>"
//    //var generatedKMLfromOtherClasses: String = ""
//    
//    func KMLGenerator(_ generatedKMLfromOtherClasses: String) -> String {
//        let openingKML = self.openingKML
//        let closingKML = self.closingKML
//        let generatedKMLfromOtherClasses = generatedKMLfromOtherClasses
//        let KML: String = "\(openingKML)\(generatedKMLfromOtherClasses)\(closingKML)"
//        print(KML)
//        return KML
//    }
//    
//}
//class Style {
//    var name: String = ""
//    var color: String = ""
//    var opacity: String = ""
//    var width: Int = 0
//    
//    func styleGenerator() -> String {
//        let name = self.name
//        let color = self.color
//        let opacity = self.opacity
//        let lineWidth = self.width
//        var colorDictionary = ["Black"         : "000000",
//                               "Red"           : "1400FF",
//                               "Orange"        : "1478FF",
//                               "Dark Yellow"   : "14B4FF",
//                               "Yellow"        : "14F0FF",
//                               "Dark Green"    : "147800",
//                               "Light green"   : "14F000",
//                               "Dark Blue"     : "780014"]
//        var transparencyPercentage = [  "0"   : "0",
//                                        "5"   : "5",
//                                        "10"  : "a",
//                                        "15"  : "f",
//                                        "20"  : "14",
//                                        "25"  : "19",
//                                        "30"  : "1e",
//                                        "35"  : "23",
//                                        "40"  : "28",
//                                        "45"  : "2d",
//                                        "50"  : "32",
//                                        "55"  : "37",
//                                        "60"  : "3c",
//                                        "65"  : "41",
//                                        "70"  : "46",
//                                        "75"  : "4b",
//                                        "80"  : "50",
//                                        "85"  : "55",
//                                        "90"  : "5a",
//                                        "95"  : "5f",
//                                        "100" : "64"]
//        let lineStyleColor = (transparencyPercentage[opacity]! + colorDictionary[color]!)
//        let style: String = "<Style id=\"\(name)\"><LineStyle><color>\(lineStyleColor)</color><width>\(lineWidth)</width></LineStyle><PolyStyle><color>\(lineStyleColor)</color></PolyStyle></Style><name>\(name)</name><description></description>"
//        //print(style)
//        return style
//    }
//    
//}
//class PolygonClass {
//    var foreFlightCoords: String = ""
//    var name: String = ""
//    var styleName: String = ""
//    var description: String = ""
//    var extrude: String = "1"
//    var tessellate: String = "1"
//    var altMode: String = "absolute"
//    
//    func FFProcessor() -> String {
//        let foreFlightCoords = self.foreFlightCoords
//        var foreFlightCoordsP = foreFlightCoords.components(separatedBy: " ")
//        let coordsSetCount = foreFlightCoordsP.count - 1
//        foreFlightCoordsP.remove(at: coordsSetCount)
//        //var coords: Array<Double> = []
//        var coordString: String = ""
//        for coordPairs in foreFlightCoordsP {
//            let new = String(describing: CoordinateTranslate(coordPairs))
//            coordString += "\(new),100\r"//CoordinateTranslate(coordPairs)
//            
//        }
//        coordString = coordString.replacingOccurrences(of: "[", with: " ")
//        coordString = coordString.replacingOccurrences(of: "]", with: " ")
//        //print(coordString)
//        return coordString
//    }
//    
//    func CoordinateTranslate(_ coords: String) -> [Double] {
//        let bullsEyeCoords = coords
//        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            //print("West")
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            //print("East")
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [longitude,lattitude]
//        //print(bullsEyeCenterPoint)
//        return bullsEyeCenterPoint
//    }
//    
//    func polygonGenerator() -> String {
//        let styleName = self.styleName
//        let name = self.name
//        let extrude = self.extrude
//        let tessellate = self.tessellate
//        let altMode = self.altMode
//        let points = "\(FFProcessor())"
//        let polygon: String = "<Placemark><name>\(name)</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(points)\r</coordinates></LineString></Placemark>"
//        return polygon
//    }
//}
//func foreFlightPaste(_ foreFlightCoords: String, _ styleName: String, _ color: String, _ opacity: String, _ width: Int ) -> String {
//    var foreFlightCoords = foreFlightCoords
//    let styleName = styleName
//    let color = color
//    let opacity = opacity
//    let width = width
//    
//    
//    let pasteboardString: String? = UIPasteboard.general.string
//    if let theString = pasteboardString {
//        foreFlightCoords = theString
//    }
//
//    let style = Style()
//    style.color = color
//    style.name = styleName
//    style.opacity = opacity
//    style.width = width
//    let s1 = style.styleGenerator()
//    
//    let new = PolygonClass()
//    new.styleName = styleName
//    new.foreFlightCoords = foreFlightCoords
//    new.FFProcessor()
//    let p1 = new.polygonGenerator()
//    
//    let KML_A = "\(s1)\(p1)"
//    
//    let kml = KML()
//    let KML_All = kml.KMLGenerator(KML_A)
//
//    //print(KML_All)
//    return KML_All
//}
//
//class Spoke {
//    var name: String = ""
//    var description: String = ""
//    var extrude: String = "1"
//    var tessellate: String = ""
//    var altMode: String = "absolute"
//    var styleName: String = ""
//    var radius: Double = 0.0
//    var centerPoint: String = ""
//    var degreesFromNinety: Double = 0.0
//    var magVariation: Double = 0.0
//    
//    func inverseDegreesFromNinety() -> Double {
//        var inverse = self.degreesFromNinety
//        if inverse > 180 {
//            inverse = inverse - 180
//        } else {
//            inverse = inverse + 180
//        }
//        return inverse
//    }
//    
//    func spokeCoordinateTranslate() -> [Double] {
//        let bullsEyeCoords = self.centerPoint
//        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        //print(bullsEyeCenterPoint)
//        return bullsEyeCenterPoint
//    }
//    
//    
//    
//    func spokeGenerator() -> String {
//        let styleName = self.styleName
//        let radiusCalculated = self.radius * (1/60)
//        let magVariation = self.magVariation
//        
//        let Xpt_1 = ((radiusCalculated/cos(spokeCoordinateTranslate()[0] * Double.pi / 180)) * cos((degreesFromNinety + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[1]
//        let Ypt_1 = (radiusCalculated * sin((degreesFromNinety + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[0]
//        let Xpt_2 = ((radiusCalculated/cos(spokeCoordinateTranslate()[0] * Double.pi / 180)) * cos((inverseDegreesFromNinety() + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[1]
//        let Ypt_2 = (radiusCalculated * sin((inverseDegreesFromNinety() + magVariation) * Double.pi / 180)) + spokeCoordinateTranslate()[0]
//        
//        let point_1 = "\(Xpt_1),\(Ypt_1),500"
//        let centerPoint = "\(spokeCoordinateTranslate()[1]),\(spokeCoordinateTranslate()[0]),500"
//        let point_2 = "\(Xpt_2),\(Ypt_2),500"
//        
//        let spoke: String = "<Placemark><name>\(name)</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(point_1)\r\(centerPoint)\r\(point_2)\r</coordinates></LineString></Placemark>"
//        //print(spoke)
//        return spoke
//    }
//    
//}
//class PlaceMark {
//    var placeMarkTitle: String = ""
//    var placeMarkDescription: String = ""
//    var placeMarkCoords: String = ""
//    
//    func placeMarkCoordinateTranslate() -> [Double] {
//        let placeMarkCoordsInt = self.placeMarkCoords
//        var coordsArray = placeMarkCoordsInt.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        return bullsEyeCenterPoint
//    }
//    
//    
//    func placeMarkGenerator() -> String {
//        
//        let placeMarkKML: String = "<Placemark><name>\(placeMarkTitle)</name><description>\(placeMarkDescription)</description><Point><coordinates>\(placeMarkCoordinateTranslate()[1]),\(placeMarkCoordinateTranslate()[0]),500</coordinates></Point></Placemark>"
//        //print(placeMarkKML)
//        return placeMarkKML
//    }
//}
//
//class BEBearingMark {
//    var description: String = ""
//    var radius: Double = 0.0
//    var centerPoint: String = ""
//    var degreesFromNinety: Int = 0
//    var BEBearingMarkerName: String = ""
//    var magVariation: Double = 0.0
//    
//    func inverseDegreesFromNinety() -> String {
//        var inverse = self.degreesFromNinety - 90
//        if inverse > 180 {
//            inverse = inverse - 180
//        } else {
//            inverse = inverse + 180
//        }
//        let stringVerse = String(inverse)
//        return stringVerse
//    }
//    
//    
//    func bearingMarkerCoordinateTranslate() -> [Double] {
//        let bullsEyeCoords = self.centerPoint
//        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        return bullsEyeCenterPoint
//    }
//    
//    
//    func BEBearingMarkerGenerator() -> String {
//        let degreesFromNinety = self.degreesFromNinety
//        let radiusCalculated = self.radius * (1/60)
//        let BEBearingMarkerName = self.BEBearingMarkerName//inverseDegreesFromNinety()
//        let magVariation = self.magVariation
//        
//        let XptBearingMarker = ((radiusCalculated/cos(bearingMarkerCoordinateTranslate()[0] * Double.pi / 180)) * cos((Double(degreesFromNinety) + magVariation) * Double.pi / 180)) + bearingMarkerCoordinateTranslate()[1]
//        let YptBearingMarker = (radiusCalculated * sin((Double(degreesFromNinety) + magVariation) * Double.pi / 180)) + bearingMarkerCoordinateTranslate()[0]
//        let bullsEyeBearingLabel: String = "<Placemark><name>\(BEBearingMarkerName)'</name><description>\(description)</description><Point><coordinates>\(XptBearingMarker),\(YptBearingMarker),100</coordinates></Point></Placemark>"
//        //print(bullsEyeBearingLabel)
//        return bullsEyeBearingLabel
//    }
//}
//class BEDistanceMarker {
//    var BEDistanceMarkerName: String = ""
//    var centerPoint: String = ""
//    var radius: Double = 0.0
//    var description: String = ""
//    var magVariation: Double = 0.0
//    
//    
//    func distanceMarkerCoordinateTranslate() -> [Double] {
//        let bullsEyeCoords = self.centerPoint
//        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        //print(bullsEyeCenterPoint)
//        return bullsEyeCenterPoint
//    }
//    
//    
//    func BEDistanceMarkerGenerator() -> String {
//        let radiusCalculated = self.radius * (1/60)
//        let bullsEyeDistance = self.BEDistanceMarkerName
//        let description = self.description
//        let magVariation = self.magVariation
//        let XptDistanceMarker = ((radiusCalculated/cos(distanceMarkerCoordinateTranslate()[0] * Double.pi / 180)) * cos((360 + magVariation) * Double.pi / 180)) + distanceMarkerCoordinateTranslate()[1]
//        let YptDistanceMarker = (radiusCalculated * sin((360 + magVariation) * Double.pi / 180)) + distanceMarkerCoordinateTranslate()[0]
//        let bullsEyeDistanceLabel: String = "<Placemark><name>\(bullsEyeDistance)NM</name><description>\(description)</description><Point><coordinates>\(XptDistanceMarker),\(YptDistanceMarker),100</coordinates></Point></Placemark>"
//        
//        return bullsEyeDistanceLabel
//        
//    }
//    
//    
//}
//class Circle {
//    var styleName: String = ""
//    var description: String = ""
//    var extrude: String = "1"
//    var tessellate: String = "1"
//    var altMode: String = "absolute"
//    var radius: Double = 0.0
//    var centerPoint: String = ""
//    //var magneticVariation: Double = 0.0
//    var centerLabelTitle: String = ""
//    var centerLabelDescription: String = ""
//    
//    func bullsEyeCoordinateTranslate() -> [Double] {
//        let bullsEyeCoords = self.centerPoint
//        var coordsArray = bullsEyeCoords.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            //print("West")
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            //print("East")
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        //print(bullsEyeCenterPoint)
//        return bullsEyeCenterPoint
//    }
//    
//    func circleGenerator () -> String {
//        let styleName = self.styleName
//        //let magVar = self.magneticVariation
//        let lattitude = bullsEyeCoordinateTranslate()[0]
//        let longitude = bullsEyeCoordinateTranslate()[1]
//        let radiusCalculated = self.radius * (1/60)
//        var circleOrderedPairs: [String] = []
//        var coordPairs: String = ""
//        
//        for i in 0 ..< 361 {
//            let j = Double(i)
//            let x = ((radiusCalculated/cos(lattitude * Double.pi / 180)) * cos(j * Double.pi / 180)) + longitude
//            let y = (radiusCalculated * sin(j * Double.pi / 180)) + lattitude
//            let Xcoord = String(x)
//            let Ycoord = String(y)
//            
//            let coordinates = "\(Xcoord),\(Ycoord)"
//            circleOrderedPairs.append(coordinates)
//        }
//        
//        for pair in circleOrderedPairs {
//            coordPairs += "\(pair),500\r"
//        }
//        
//        let circleKML: String = "<Placemark><name>\(String(radiusCalculated))</name><description>\(description)</description><styleUrl>#\(styleName)</styleUrl><LineString><extrude>\(extrude)</extrude><tessellate>\(tessellate)</tessellate><altitudeMode>\(altMode)</altitudeMode><coordinates>\(coordPairs)</coordinates></LineString></Placemark>"
//        //print(circleKML)
//        return (circleKML)
//        
//    }
//    func circleCenterLabelGenerator() -> String {
//        
//        let canterLabelKML: String = "<Placemark><name>\(centerLabelTitle)</name><description>\(centerLabelDescription)</description><Point><coordinates>\(bullsEyeCoordinateTranslate()[1]),\(bullsEyeCoordinateTranslate()[0]),500</coordinates></Point></Placemark>"
//        //print(placeMarkKML)
//        return canterLabelKML
//    }
//    
//}
//
//func bullsEye(_ bullsEyeName: String, _ color: String, _ opacity: String, _ width: Int, _ styleName: String, _ radiusOfOuterRing: Double, _ centerPoint: String, _ magVariation: Double) -> String {
//    let bullsEyeName = bullsEyeName
//    let color = color
//    let opacity = opacity
//    let width = width
//    let centerPoint = centerPoint
//    let radiusOfOuterRing = radiusOfOuterRing
//    let styleName = styleName
//    let magVariation = magVariation
//    
//    let bullsEyeStyle = Style()
//    bullsEyeStyle.color = color
//    bullsEyeStyle.name = styleName
//    bullsEyeStyle.opacity = opacity
//    bullsEyeStyle.width = width
//    let style1 = bullsEyeStyle.styleGenerator()
//    
//    let bullsEyeNameMarker = PlaceMark()
//    bullsEyeNameMarker.placeMarkTitle = bullsEyeName
//    bullsEyeNameMarker.placeMarkCoords = centerPoint
//    let BEName = bullsEyeNameMarker.placeMarkGenerator()
//    
//    let distanceMarker_01 = BEDistanceMarker()
//    distanceMarker_01.centerPoint = centerPoint
//    distanceMarker_01.radius = (radiusOfOuterRing/6)*2
//    distanceMarker_01.BEDistanceMarkerName = String(Int(distanceMarker_01.radius))
//    distanceMarker_01.magVariation = magVariation
//    let DM_01 = distanceMarker_01.BEDistanceMarkerGenerator()
//    
//    let distanceMarker_02 = BEDistanceMarker()
//    distanceMarker_02.centerPoint = centerPoint
//    distanceMarker_02.radius = (radiusOfOuterRing/6)*4
//    distanceMarker_02.BEDistanceMarkerName = String(Int(distanceMarker_02.radius))
//    distanceMarker_02.magVariation = magVariation
//    let DM_02 = distanceMarker_02.BEDistanceMarkerGenerator()
//    
//    let bearingMarker_01 = BEBearingMark()
//    bearingMarker_01.BEBearingMarkerName = "\(String(Int(radiusOfOuterRing)))-90"
//    bearingMarker_01.centerPoint = centerPoint
//    bearingMarker_01.degreesFromNinety = 0
//    bearingMarker_01.magVariation = magVariation
//    bearingMarker_01.description = ""
//    bearingMarker_01.radius = radiusOfOuterRing
//    let BE_01 = bearingMarker_01.BEBearingMarkerGenerator()
//    
//    let bearingMarker_02 = BEBearingMark()
//    bearingMarker_02.BEBearingMarkerName = "45"
//    bearingMarker_02.centerPoint = centerPoint
//    bearingMarker_02.degreesFromNinety = 45
//    bearingMarker_02.magVariation = magVariation
//    bearingMarker_02.description = ""
//    bearingMarker_02.radius = radiusOfOuterRing
//    let BE_02 = bearingMarker_02.BEBearingMarkerGenerator()
//    
//    let bearingMarker_03 = BEBearingMark()
//    bearingMarker_03.BEBearingMarkerName = "360"
//    bearingMarker_03.centerPoint = centerPoint
//    bearingMarker_03.degreesFromNinety = 90
//    bearingMarker_03.magVariation = magVariation
//    bearingMarker_03.description = ""
//    bearingMarker_03.radius = radiusOfOuterRing
//    let BE_03 = bearingMarker_03.BEBearingMarkerGenerator()
//    
//    let bearingMarker_04 = BEBearingMark()
//    bearingMarker_04.BEBearingMarkerName = "315"
//    bearingMarker_04.centerPoint = centerPoint
//    bearingMarker_04.degreesFromNinety = 135
//    bearingMarker_04.magVariation = magVariation
//    bearingMarker_04.description = ""
//    bearingMarker_04.radius = radiusOfOuterRing
//    let BE_04 = bearingMarker_04.BEBearingMarkerGenerator()
//    
//    let bearingMarker_05 = BEBearingMark()
//    bearingMarker_05.BEBearingMarkerName = "270"
//    bearingMarker_05.centerPoint = centerPoint
//    bearingMarker_05.degreesFromNinety = 180
//    bearingMarker_05.magVariation = magVariation
//    bearingMarker_05.description = ""
//    bearingMarker_05.radius = radiusOfOuterRing
//    let BE_05 = bearingMarker_05.BEBearingMarkerGenerator()
//    
//    let bearingMarker_06 = BEBearingMark()
//    bearingMarker_06.BEBearingMarkerName = "225"
//    bearingMarker_06.centerPoint = centerPoint
//    bearingMarker_06.degreesFromNinety = 225
//    bearingMarker_06.magVariation = magVariation
//    bearingMarker_06.description = ""
//    bearingMarker_06.radius = radiusOfOuterRing
//    let BE_06 = bearingMarker_06.BEBearingMarkerGenerator()
//    
//    let bearingMarker_07 = BEBearingMark()
//    bearingMarker_07.BEBearingMarkerName = "180"
//    bearingMarker_07.centerPoint = centerPoint
//    bearingMarker_07.degreesFromNinety = 270
//    bearingMarker_07.magVariation = magVariation
//    bearingMarker_07.description = ""
//    bearingMarker_07.radius = radiusOfOuterRing
//    let BE_07 = bearingMarker_07.BEBearingMarkerGenerator()
//    
//    let bearingMarker_08 = BEBearingMark()
//    bearingMarker_08.BEBearingMarkerName = "135"
//    bearingMarker_08.centerPoint = centerPoint
//    bearingMarker_08.degreesFromNinety = 315
//    bearingMarker_08.magVariation = magVariation
//    bearingMarker_08.description = ""
//    bearingMarker_08.radius = radiusOfOuterRing
//    let BE_08 = bearingMarker_08.BEBearingMarkerGenerator()
//    
//    let circle_01 = Circle()
//    circle_01.styleName = styleName
//    circle_01.radius = radiusOfOuterRing/6
//    circle_01.centerPoint = centerPoint
//    let c1 = circle_01.circleGenerator()
//    
//    let circle_02 = Circle()
//    circle_02.styleName = styleName
//    circle_02.radius = (radiusOfOuterRing/6)*2
//    circle_02.centerPoint = centerPoint
//    let c2 = circle_02.circleGenerator()
//    
//    let circle_03 = Circle()
//    circle_03.styleName = styleName
//    circle_03.radius = (radiusOfOuterRing/6)*3
//    circle_03.centerPoint = centerPoint
//    let c3 = circle_03.circleGenerator()
//    
//    let circle_04 = Circle()
//    circle_04.styleName = styleName
//    circle_04.radius = (radiusOfOuterRing/6)*4
//    circle_04.centerPoint = centerPoint
//    let c4 = circle_04.circleGenerator()
//    
//    let circle_05 = Circle()
//    circle_05.styleName = styleName
//    circle_05.radius = (radiusOfOuterRing/6)*5
//    circle_05.centerPoint = centerPoint
//    let c5 = circle_05.circleGenerator()
//    
//    let circle_06 = Circle()
//    circle_06.styleName = styleName
//    circle_06.radius = (radiusOfOuterRing/6)*6
//    circle_06.centerPoint = centerPoint
//    let c6 = circle_06.circleGenerator()
//    
//    let spoke_01 = Spoke()
//    spoke_01.centerPoint = centerPoint
//    spoke_01.degreesFromNinety = 0.0
//    spoke_01.styleName = styleName
//    spoke_01.radius = radiusOfOuterRing
//    spoke_01.magVariation = magVariation
//    let s1 = spoke_01.spokeGenerator()
//    
//    let spoke_02 = Spoke()
//    spoke_02.centerPoint = centerPoint
//    spoke_02.degreesFromNinety = 45.0
//    spoke_02.styleName = styleName
//    spoke_02.radius = radiusOfOuterRing
//    spoke_02.magVariation = magVariation
//    let s2 = spoke_02.spokeGenerator()
//    
//    let spoke_03 = Spoke()
//    spoke_03.centerPoint = centerPoint
//    spoke_03.degreesFromNinety = 90.0
//    spoke_03.styleName = styleName
//    spoke_03.radius = radiusOfOuterRing
//    spoke_03.magVariation = magVariation
//    let s3 = spoke_03.spokeGenerator()
//    
//    let spoke_04 = Spoke()
//    spoke_04.centerPoint = centerPoint
//    spoke_04.degreesFromNinety = 135.0
//    spoke_04.styleName = styleName
//    spoke_04.radius = radiusOfOuterRing
//    spoke_04.magVariation = magVariation
//    let s4 = spoke_04.spokeGenerator()
//    
//    let internalKML: String = "\(style1)\(BEName)\(DM_01)\(DM_02)\(BE_01)\(BE_02)\(BE_03)\(BE_04)\(BE_05)\(BE_06)\(BE_07)\(BE_08)\(s1)\(s2)\(s3)\(s4)\(c1)\(c2)\(c3)\(c4)\(c5)\(c6)"
//    
//    //let openingAndClosingKML = KML()
//    //let KML_All = openingAndClosingKML.KMLGenerator(internalKML)
//    //print(KML_All)
//    return internalKML
//    
//}
//
//
//
//var userBE_CenterPoint = "36.0N/78.0W"
//var userBE_Name = "New"
//var userBE_Color = "Black"
//var userBE_Opacity = "100"
//var userBE_Width = 10
//var userBE_StyleName = "BE"
//var userBE_Size = 100.0
//var userMagVar = 7.0
//var BE_KML = bullsEye(userBE_Name, userBE_Color, userBE_Opacity, userBE_Width, userBE_StyleName, userBE_Size, userBE_CenterPoint, userMagVar)
//
//var threatStyle = Style()
//threatStyle.color = "Red"
//threatStyle.name = "Threat"
//threatStyle.opacity = "100"
//threatStyle.width = 30
//var threatStyleKML = threatStyle.styleGenerator()
//
//
//var threatCenterPoint1 = "35.50N/77.85W"
//var threatCenterPoint2 = "36.2N/78.45W"
//var threat = Circle()
//threat.centerPoint = threatCenterPoint1
//threat.styleName = threatStyle.name
//threat.radius = 1.0
//threat.centerLabelTitle = "DaniPo"
//var threatLabel = threat.circleCenterLabelGenerator()
//var threatKML = threat.circleGenerator()
//
//
//
//
//var allOtherKML = "\(BE_KML),\(threatStyleKML),\(threatKML),\(threatLabel),\(threatKML)"
//var KML_Code = KML()
//KML_Code.KMLGenerator(allOtherKML)
//
//class PlaceMark {
//    var placeMarkTitle: String = ""
//    var placeMarkDescription: String = ""
//    var placeMarkCoords: String = ""
//    
//    func placeMarkCoordinateTranslate() -> [Double] {
//        let placeMarkCoordsInt = self.placeMarkCoords
//        var coordsArray = placeMarkCoordsInt.components(separatedBy: "/")
//        var lattitude: Double = 0.0
//        var longitude = 0.0
//        if coordsArray[0].range(of: "N") != nil {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = Double(lattitudeString)!
//        } else {
//            let lattitudeString = String(coordsArray[0].characters.dropLast())
//            lattitude = -1 * Double(lattitudeString)!
//        }
//        if coordsArray[1].range(of: "W") != nil {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = -1 * Double(longitudeString)!
//        } else {
//            let longitudeString = String(coordsArray[1].characters.dropLast())
//            longitude = Double(longitudeString)!
//        }
//        let bullsEyeCenterPoint: Array = [lattitude,longitude]
//        return bullsEyeCenterPoint
//    }
//    
//    
//    func placeMarkGenerator() -> String {
//        
//        let placeMarkKML: String = "<Placemark><name>\(placeMarkTitle)</name><description>\(placeMarkDescription)</description><Point><coordinates>\(placeMarkCoordinateTranslate()[1]),\(placeMarkCoordinateTranslate()[0]),500</coordinates></Point></Placemark>"
//        //print(placeMarkKML)
//        return placeMarkKML
//    }
//}
//
//
//
//class Threat: Circle {
//    var GPSLattitude: Double = 0.0
//    var GPSLongitude: Double = 0.0
//    var userInputRange: Double = 0.0
//    var userInputBearing: Double = 0.0
//    
//    func getThreatCoords() -> [Double]{
//        let GPSLattitude = self.GPSLattitude
//        let GPSLongitude = self.GPSLongitude
//        let userInputRange = self.userInputRange
//        let userInputBearing = self.userInputBearing
//        let radiusCalculated = userInputRange/60
//        let theta = 270 - userInputBearing
//        let x = (radiusCalculated/(cos(GPSLattitude*(Double.pi/180)))*(cos((theta*Double.pi)/180)))+GPSLongitude
//        let y = (radiusCalculated*sin(Double.pi/180))+GPSLattitude
//        let coords = [x,y]
//        //print(coords)
//        return coords
//    }
//
//    func threatLabel() ->String {
//       
//    }
//
//}


//var threat = Threat()
//threat.GPSLattitude = 37.785834
//threat.GPSLongitude = -122.406417
//threat.userInputBearing = 270
//threat.userInputRange = 30
//
//
//
//
////Lattitude:  37.785834
////Longitude:  -122.406417
//
















