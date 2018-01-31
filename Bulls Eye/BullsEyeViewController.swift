//
//  SecondViewController.swift
//  Bulls Eye
//
//  Created by elmo on 8/19/17.
//  Copyright © 2017 elmo. All rights reserved.
//

import UIKit
import CoreLocation

class BullsEyeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate{
    
    // ForeFlight Format: 38.30943N/88.00854W 38.05367N/88.45148W 37.79306N/87.95454W 38.12465N/87.73879W 38.4178N/87.70232W 60000ft
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var overLayFileName_TextField: UITextField!
    @IBOutlet weak var bullsEyeName_TextField: UITextField!
    @IBOutlet weak var bullsEyeCenterPoint_TextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == overLayFileName_TextField {
            bullsEyeName_TextField.becomeFirstResponder()
        } else if textField == bullsEyeName_TextField {
            bullsEyeCenterPoint_TextField.becomeFirstResponder()
        } else {
            bullsEyeCenterPoint_TextField.resignFirstResponder()
        }
        return true
    }
    
    
    
    
    
    //COLOR PICKER
    @IBOutlet weak var bullsEyeColor_PickerView: UIPickerView!
    var ColorArray = ["Black",
                      "Red",
                      "Orange",
                      "Dark Yellow",
                      "Yellow",
                      "Dark Green",
                      "Light green",
                      "Dark Blue",]
    var widthArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ColorArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ColorArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Variables.BE_color = ColorArray[row]
    }
    
    //OPACITY SLIDER
    @IBOutlet weak var opacity_Label: UILabel!
    @IBOutlet weak var bullsEyeOpacity_SliderControl: UISlider!
    @IBAction func bullsEyeOpacity_Slider(_ sender: Any) {
        
        let sliderValue = Int(bullsEyeOpacity_SliderControl.value)
        opacity_Label.text = "\(String(Int(bullsEyeOpacity_SliderControl.value)))%"
        
        if sliderValue < 5 {
            Variables.BE_opacity = "0"
        } else if sliderValue < 10 {
            Variables.BE_opacity = "5"
        } else if sliderValue < 15 {
            Variables.BE_opacity = "10"
        }else if sliderValue < 20 {
            Variables.BE_opacity = "15"
        }else if sliderValue < 25 {
            Variables.BE_opacity = "20"
        }else if sliderValue < 30 {
            Variables.BE_opacity = "25"
        }else if sliderValue < 35 {
            Variables.BE_opacity = "30"
        }else if sliderValue < 40 {
            Variables.BE_opacity = "35"
        }else if sliderValue < 45 {
            Variables.BE_opacity = "40"
        }else if sliderValue < 50 {
            Variables.BE_opacity = "45"
        }else if sliderValue < 55 {
            Variables.BE_opacity = "50"
        }else if sliderValue < 60 {
            Variables.BE_opacity = "55"
        }else if sliderValue < 65 {
            Variables.BE_opacity = "60"
        }else if sliderValue < 70 {
            Variables.BE_opacity = "65"
        }else if sliderValue < 75 {
            Variables.BE_opacity = "70"
        }else if sliderValue < 80 {
            Variables.BE_opacity = "75"
        }else if sliderValue < 85 {
            Variables.BE_opacity = "80"
        }else if sliderValue < 90 {
            Variables.BE_opacity = "85"
        }else if sliderValue < 95 {
            Variables.BE_opacity = "90"
        }else if sliderValue < 100 {
            Variables.BE_opacity = "95"
        }else {
            Variables.BE_opacity = "100"
        }
        UserDefaults.standard.set(Variables.BE_opacity, forKey: "BE_opacity")
        
    }
    
    //WIDTH SLIDER
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var widthSlider: UISlider!
    @IBAction func widthSlider(_ sender: Any) {
        widthLabel.text = "\(String(Int(widthSlider.value)))"
        Variables.BE_width = Int(widthSlider.value)
        UserDefaults.standard.set(Variables.BE_width, forKey: "BE_width")
    }
    
    //OUTER RING SIZE
    @IBOutlet weak var BESizeSliderLabel: UILabel!
    @IBOutlet weak var BESizeSlider: UISlider!
    @IBAction func BESizeSlider_(_ sender: Any) {
        BESizeSliderLabel.text = "\(String(Int(BESizeSlider.value))) NM"
        Variables.BE_radiusOfOuterRing = Double(Int(BESizeSlider.value))
        UserDefaults.standard.set(Variables.BE_radiusOfOuterRing, forKey: "BE_radiusOfOuterRing")
    }
    
    //MAGNETIC VARIATION SLIDER
    @IBOutlet weak var magVarLabel: UILabel!
    @IBOutlet weak var magVarSlider: UISlider!
    @IBAction func magVarSlider(_ sender: Any) {
        magVarLabel.text = "\(String(Int(magVarSlider.value)))"
        Variables.BE_magVariation = Double(Int(magVarSlider.value))
        UserDefaults.standard.set(Variables.BE_magVariation, forKey: "BE_magVariation")
        print(String(Int(magVarSlider.value)))
        
    }
    
    func coordinateTranslate(_ coords: String) -> [Double] {
        let coords = coords.capitalized
        var coordsArray = coords.components(separatedBy: "/")
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
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = -1 * Double(longitudeString)!
        } else {
            let longitudeString = String(coordsArray[1].dropLast())
            longitude = Double(longitudeString)!
        }
        let coordCalculatedArray: Array = [lattitude,longitude]
        return coordCalculatedArray
    }

    @IBAction func setBullsEyeInformation_Button(_ sender: Any) {
        if overLayFileName_TextField.text! != "" {
            Variables.overlayFileName! = overLayFileName_TextField.text!
            UserDefaults.standard.set(Variables.overlayFileName, forKey: "overlayFileName")
        } else {
            let alert  = UIAlertController(title: "MISSING FILE NAME!", message: "Please enter a file name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
       }
        
        if bullsEyeName_TextField.text! != "" {
            Variables.BE_Name! = bullsEyeName_TextField.text!
            UserDefaults.standard.set(Variables.BE_Name, forKey: "BE_Name")
        } else {
            let alert  = UIAlertController(title: "MISSING NAME!", message: "Please enter a name for the Bulls Eye / SARDOT", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
            bullsEyeName_Label.text = "Blank"
        }
        
        if bullsEyeCenterPoint_TextField.text! != "" {
            Variables.BE_centerPoint! = bullsEyeCenterPoint_TextField.text!.capitalized
            UserDefaults.standard.set(Variables.BE_centerPoint, forKey: "BE_centerPoint")
            Variables.BE_centerPointCalculatedArray = coordinateTranslate(Variables.BE_centerPoint!.capitalized)
            UserDefaults.standard.set(Variables.BE_centerPointCalculatedArray, forKey: "coordsCalculated")
        } else {
            let alert  = UIAlertController(title: "MISSING CENTERPOINT!", message: "Please enter the Bulls Eye / SARDOT centerpoint coordinates in the format: DD.ddN/DD.ddW", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
        savedBullsEyeInformation()
        let bullsEye = BullsEye()
        Variables.BE_KML = bullsEye.bullsEye()
        UserDefaults.standard.set(Variables.BE_KML, forKey: "BullsEye")
        
    }
    //Generates the KML file and exports it to the share sheet
    @IBAction func createKML(_ sender: Any) {
        let fileName = "\(Variables.overlayFileName ?? "BullsEye").kml"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        
        let bullsEye = BullsEye()
        let bullsEyeKML = bullsEye.bullsEye()
        let KML_OpenAndClose = KML()
        let KMLFile = KML_OpenAndClose.KMLGenerator(bullsEyeKML)
        
        
        do {
            try KMLFile.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path as Any], applicationActivities: [])
            vc.popoverPresentationController?.sourceView = self.view
            vc.excludedActivityTypes = [
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToTencentWeibo,
                UIActivityType.postToTwitter,
                UIActivityType.postToFacebook,
                UIActivityType.openInIBooks
            ]
            print("Success")
            present(vc, animated: true, completion: nil)
            print(KMLFile)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    @IBAction func ForeFlightButton(_ sender: Any) {
        Variables.overlayFileName = overLayFileName_TextField.text!.capitalized
        let fileName = "\(Variables.overlayFileName ?? "BullsEye").kml"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        let KMLFile = foreFlightPaste("foreflight", Variables.BE_color, Variables.BE_opacity, Variables.BE_width)
        do {
            try KMLFile.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path as Any], applicationActivities: [])
            vc.popoverPresentationController?.sourceView = self.view
            vc.excludedActivityTypes = [
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToTencentWeibo,
                UIActivityType.postToTwitter,
                UIActivityType.postToFacebook,
                UIActivityType.openInIBooks
            ]
            print("Success")
            present(vc, animated: true, completion: nil)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
    }
    
    func foreFlightPaste(_ styleName: String, _ color: String, _ opacity: String, _ width: Int ) -> String {
        var foreFlightCoords: String = ""
        let styleName = styleName
        let color = color
        let opacity = opacity
        let width = width
        let pasteboardString: String? = UIPasteboard.general.string
        if let theString = pasteboardString {
            foreFlightCoords = theString
        }
        let style = Style()
        style.color = color
        style.name = styleName
        style.opacity = opacity
        style.width = width
        let s1 = style.styleGenerator()
        let new = PolygonClass()
        new.styleName = styleName
        new.foreFlightCoords = foreFlightCoords
        //new.FFProcessor()
        let p1 = new.polygonGenerator()
        let KML_A = "\(s1)\(p1)"
        let kml = KML()
        let KML_All = kml.KMLGenerator(KML_A)
        print(KML_All)
        return KML_All
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
        if let location = didUpdateLocations.first {
            _ = location
        }
        //in info.plist   <-- add the following
        //Privacy - Location when in use description:   This is used to determine your aircrafts postion
        //Privacy - Location always description:            This is used to determine your aircrafts postion in the background
    }
    
    //SAVED BULLSEYE Labels
    @IBOutlet weak var overLayFileName_Label: UILabel!
    @IBOutlet weak var bullsEyeName_Label: UILabel!
    @IBOutlet weak var bullsEyeCenterPoint_Label: UILabel!
    @IBOutlet weak var bullsEyeColor_Label: UILabel!
    @IBOutlet weak var bullsEyeOpacity_Label: UILabel!
    @IBOutlet weak var bullsEyeLineThickness_Label: UILabel!
    @IBOutlet weak var bullsEyeMagVariation_Label: UILabel!
    @IBOutlet weak var bullsEyeSize_Label: UILabel!
    func savedBullsEyeInformation(){
        if Variables.overlayFileName == nil {//|| overLayFileName_TextField.text == "" {
            Variables.overlayFileName = "Overlay"
        }
        if Variables.BE_Name == nil {
            Variables.BE_Name = "BullsEye"
        }
        if Variables.BE_centerPoint == nil {
            Variables.BE_centerPoint = "0.0N/0.0W"
            bullsEyeCenterPoint_Label.text = "0.0N/0.0W"
            bullsEyeCenterPoint_TextField.text = "0.0N/0.0W"
        }
        overLayFileName_Label.text = Variables.overlayFileName
        if let overlayFileNameDefault = UserDefaults.standard.object(forKey: "overlayFileName") as? String {
            overLayFileName_Label.text = overlayFileNameDefault
        }
        bullsEyeName_Label.text = Variables.BE_Name
        if let bullsEyeNameDefault = UserDefaults.standard.object(forKey: "BE_Name") as? String {
            bullsEyeName_Label.text = bullsEyeNameDefault
        }
        bullsEyeCenterPoint_Label.text = Variables.BE_centerPoint?.capitalized
        if let bullsEyeCenterPointDefault = UserDefaults.standard.object(forKey: "BE_centerPoint") as? String {
            bullsEyeCenterPoint_Label.text = bullsEyeCenterPointDefault
        }
        bullsEyeColor_Label.text = Variables.BE_color
        if let BE_colorDefault = UserDefaults.standard.object(forKey: "BE_color") as? String {
            bullsEyeColor_Label.text = BE_colorDefault
        }
        bullsEyeOpacity_Label.text = Variables.BE_opacity
        if let BE_opacityDefault = UserDefaults.standard.object(forKey: "BE_opacity") as? String {
            bullsEyeOpacity_Label.text = BE_opacityDefault
            //opacity width BEsize magVar
            opacity_Label.text = BE_opacityDefault
            bullsEyeOpacity_SliderControl.value = Float(BE_opacityDefault)!
        }
        bullsEyeLineThickness_Label.text = String(Variables.BE_width)
        if let BE_widthDefault = UserDefaults.standard.object(forKey: "BE_width") as? String {
            bullsEyeLineThickness_Label.text = BE_widthDefault
        }
        bullsEyeMagVariation_Label.text = String(Variables.BE_magVariation)
        if let BE_magVariationDefault = UserDefaults.standard.object(forKey: "BE_magVariation") as? String {
            bullsEyeMagVariation_Label.text = BE_magVariationDefault
        }
        bullsEyeSize_Label.text = String(Variables.BE_radiusOfOuterRing)
        if let BE_radiusOfOuterRingDefault = UserDefaults.standard.object(forKey: "BE_radiusOfOuterRing") as? String {
            bullsEyeSize_Label.text = BE_radiusOfOuterRingDefault
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bullsEyeColor_PickerView.dataSource = self
        bullsEyeColor_PickerView.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if let overlayFileNameDefault = UserDefaults.standard.object(forKey: "overlayFileName") as? String {
            Variables.overlayFileName = overlayFileNameDefault
            overLayFileName_Label.text = Variables.overlayFileName
        }
        
        if let opacitySliderDefault = UserDefaults.standard.object(forKey: "BE_opacity") {
            Variables.BE_opacity = opacitySliderDefault as! String
            opacity_Label.text = Variables.BE_opacity
        }
        
        if let lineWidthDefault = UserDefaults.standard.object(forKey: "BE_width") {
            Variables.BE_width = lineWidthDefault as! Int
            widthLabel.text = String(Variables.BE_width)
        }
        if let magVariationDefault = UserDefaults.standard.object(forKey: "BE_magVariation") {
            Variables.BE_magVariation = magVariationDefault as! Double
            magVarLabel.text = String(Variables.BE_magVariation)
        }
        
        if let bullsEyeSizeDefault = UserDefaults.standard.object(forKey: "BE_radiusOfOuterRing") {
            Variables.BE_radiusOfOuterRing = bullsEyeSizeDefault as! Double
            BESizeSliderLabel.text = String(Variables.BE_radiusOfOuterRing)
        }
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        savedBullsEyeInformation()
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

