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
   
    
   
    
    
    @IBOutlet weak var coordFormatPopupOutlet: UIButton!
    @IBAction func coordFormatPopupButton(_ sender: UIButton) {
    }
    
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
    
    // MARK: BULLS EYE SIZE
    @IBOutlet weak var BESizeSliderLabel: UILabel!
    @IBAction func BESizeStepper(_ sender: UIStepper) {
        BESizeSliderLabel.text = "\(String(format: "%.0f", sender.value)) NM"
        Variables.BE_radiusOfOuterRing = Double(sender.value)
    }
    
    
    // MARK: MAGNETIC VARIATION STEPPER
    @IBOutlet weak var magVarLabel: UILabel!
    @IBAction func magVarStepper(_ sender: UIStepper) {
        magVarLabel.text = String(format: "%.1f", sender.value)
        Variables.BE_magVariation = sender.value
        UserDefaults.standard.set(Variables.BE_magVariation, forKey: "BE_magVariation")

    }
    
    // MARK: CURRENT MAG VAR BUTTON
    @IBOutlet weak var currentMagVarButtonOutlet: UIButton!
    @IBAction func currentMagVarButton(_ sender: UIButton) {
        magVarLabel.text = String(format: "%.1f", (Variables.UserMagVariation))
        UserDefaults.standard.set(Variables.BE_magVariation, forKey: "BE_magVariation")

        //Setting User Defaults:
        Variables.BE_magVariation = Variables.UserMagVariation
    }
    
    // MARK: Coordinate Translator
    func coordinateTranslate(_ coords: String) -> [Double] {
        let coords = coords.coordTranslate()
        return coords
        
    }

    // MARK: Set Bulls Eye Button
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
            let bullsEyeLat = String(format: "%.4f", bullsEyeCenterPoint_TextField.text!.capitalized.coordTranslate()[0])
            let bullsEyeLong = String(format: "%.4f", bullsEyeCenterPoint_TextField.text!.capitalized.coordTranslate()[1])
            Variables.BE_centerPoint! = "\(bullsEyeLat)/\(bullsEyeLong)"    // bullsEyeCenterPoint_TextField.text!.capitalized
            UserDefaults.standard.set(Variables.BE_centerPoint, forKey: "BE_centerPoint")
            Variables.BE_centerPointCalculatedArray = coordinateTranslate(Variables.BE_centerPoint!.capitalized)
            UserDefaults.standard.set(Variables.BE_centerPointCalculatedArray, forKey: "coordsCalculated")
        } else {
            let alert  = UIAlertController(title: "MISSING CENTERPOINT!", message: "Please enter the Bulls Eye / SARDOT centerpoint coordinates in the format: DD.ddN/DD.ddW", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
        //Setting Defaults
        UserDefaults.standard.set(Variables.BE_magVariation, forKey: "BE_magVariation")
        UserDefaults.standard.set(Variables.BE_radiusOfOuterRing, forKey: "BE_radiusOfOuterRing")
        
        savedBullsEyeInformation()
        let bullsEye = BullsEye()
        Variables.BE_KML = bullsEye.bullsEye()
        UserDefaults.standard.set(Variables.BE_KML, forKey: "BullsEye")
        
    }
    
    // MARK: Generate Overlay
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
    
    // MARK: ForeFlight Button
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
    
    // MARK: ForeFlight C&P FlightPlan
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
    
    // MARK: OutPutLabels
    @IBOutlet weak var overLayFileName_Label: UILabel!
    @IBOutlet weak var bullsEyeName_Label: UILabel!
    @IBOutlet weak var bullsEyeCenterPoint_Label: UILabel!
    @IBOutlet weak var bullsEyeColor_Label: UILabel!
    @IBOutlet weak var bullsEyeMagVariation_Label: UILabel!
    @IBOutlet weak var bullsEyeSize_Label: UILabel!
   
    // MARK: Saved BE Information
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
            let BECP = bullsEyeCenterPointDefault.coordTranslate()
            let lat = BECP[0].lat_DDdddd_To_DDMMdd()
            let long = BECP[1].long_DDdddd_To_DDMMdd()
            bullsEyeCenterPoint_Label.text = "\(lat)/\(long)"
        }
        bullsEyeColor_Label.text = Variables.BE_color
        if let BE_colorDefault = UserDefaults.standard.object(forKey: "BE_color") as? String {
            bullsEyeColor_Label.text = BE_colorDefault
        }
        bullsEyeMagVariation_Label.text = String(format: "%.1f", Variables.BE_magVariation)
        if let BE_magVariationDefault = UserDefaults.standard.object(forKey: "BE_magVariation") as? String {
            bullsEyeMagVariation_Label.text = String(format: "%.1f", BE_magVariationDefault)
        }
        bullsEyeSize_Label.text = "\(String(format: "%.0f", Variables.BE_radiusOfOuterRing)) NM"
        if let BE_radiusOfOuterRingDefault = UserDefaults.standard.object(forKey: "BE_radiusOfOuterRing") as? String {
            bullsEyeSize_Label.text = "\(String(format: "%.0f", BE_radiusOfOuterRingDefault)) NM"
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
        } else {
            overLayFileName_Label.text = ""
        }

        if let opacitySliderDefault = UserDefaults.standard.object(forKey: "BE_opacity") {
            Variables.BE_opacity = opacitySliderDefault as! String
        }
        
        if let lineWidthDefault = UserDefaults.standard.object(forKey: "BE_width") {
            Variables.BE_width = lineWidthDefault as! Int
        }
        if let magVariationDefault = UserDefaults.standard.object(forKey: "BE_magVariation") {
            Variables.BE_magVariation = magVariationDefault as! Double
            magVarLabel.text = String(format: "%.1f", (Variables.BE_magVariation))
        } 
        
        if let bullsEyeSizeDefault = UserDefaults.standard.object(forKey: "BE_radiusOfOuterRing") {
            Variables.BE_radiusOfOuterRing = bullsEyeSizeDefault as! Double
            BESizeSliderLabel.text = "\(String(format: "%.0f", Variables.BE_radiusOfOuterRing)) NM"
        } else {
            Variables.BE_radiusOfOuterRing = 200.0
            BESizeSliderLabel.text = "200 NM"
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

