//
//  FirstViewController.swift
//  Bulls Eye
//
//  Created by elmo on 8/19/17.
//  Copyright © 2017 elmo. All rights reserved.
//


import UIKit
import CoreLocation

class PlotsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    var bullsEyeKML = String()
    //var bullsEyeCenterPoint = "40N/121W"
    var bullsEyeCenterPointArray: [Double] = []
    var threatKML: String = ""
    var threatLabel: String = ""
    var threatColor = "Red"

    //Table
    @IBOutlet weak var threatsTable: UITableView!
    var threats = [""]
    var threatDictionary = [String: Array<Any>]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(threats.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let threatCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "threatCell")
        threatCell.textLabel?.text = threats[indexPath.row]
        return(threatCell)
    }
    
    //SLIDE to DELETE
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            threatDictionary.removeValue(forKey: threats[indexPath.row])
            threats.remove(at: indexPath.row)
            print(threatDictionary)
            tableView.reloadData()
        }
    }
    
    //Buttons
    @IBOutlet weak var saveThreatButtonStyle: UIButton!
    @IBAction func saveThreatButton(_ sender: Any) {
        Variables.UI_threatName = threatNameTextField.text!
        let threatName = Variables.UI_threatName
        Variables.UI_inputRange = Double(threatRangeTextField.text!)!
        let threatRange = Double(threatRangeTextField.text!)
        Variables.UI_inputBearing = Double(threatBearingTextField.text!)!
        let threatBearing = Double(threatBearingTextField.text!)
        let threatColor = Variables.UI_threatColor
        
        
        UserDefaults.standard.set(threats, forKey: "threats")
        UserDefaults.standard.set(threatDictionary, forKey: "threatDictionary")
        let threat1 = Threat()
        //threat1.threatName = threatName
        threat1.GPSLattitude = (locationManager.location?.coordinate.latitude)!
        threat1.GPSLongitude = (locationManager.location?.coordinate.longitude)!
        threat1.threatColor = threatColor
        threat1.userInputRange = threatRange!
        threat1.userInputBearing = threatBearing!
        bullsEyeCenterPointArray = Variables.BE_centerPointCalculatedArray
    
        
        let threatDistance = threat1.distanceCalculator(bullsEyeCenterPointArray)
        let threatBearingFromBullsEye = threat1.bearingCalculator(bullsEyeCenterPointArray)
        threat1.threatName = "\(threatName):\(String(Int(threatBearingFromBullsEye)))\u{00B0}:\(String(Int(threatDistance)))NM"
        threatKML += threat1.threatPlot()
        threats.append(threatName)
        threatDictionary[threatName] = [Double(threatRange!),Double(threatBearing!),threatDistance,threatColor]
        threatsTable.reloadData()
        
        print(bullsEyeCenterPointArray)
        print(threatDictionary)
        print(threatBearingFromBullsEye)
    }
    @IBAction func clearAllThreatsButtons(_ sender: Any) {
        threats.removeAll()
        threatDictionary.removeAll()
        threatsTable.reloadData()
        UserDefaults.standard.set(threats, forKey: "threats")
        UserDefaults.standard.set(threatDictionary, forKey: "threatDictionary")
        threatKML = ""
    }
    
    
    @IBOutlet weak var generateAndExportButtonStyle: UIButton!
    @IBAction func generateAndExportButton(_ sender: Any) {
        if let x = UserDefaults.standard.object(forKey: "BullsEye") {
            bullsEyeKML = x as! String
            let internalKML = "\(threatKML),\(bullsEyeKML)"
            let KML_ALL = KML()
            let KML_StringReadyForExport = KML_ALL.KMLGenerator(internalKML)
            if let overlayFileNameDefault = UserDefaults.standard.object(forKey: "overlayFileName"){
                Variables.overlayFileName = (overlayFileNameDefault as! String)
            }
            let fileName = "\(Variables.overlayFileName ?? "BullsEye").kml"
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            do {
                try KML_StringReadyForExport.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
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
        } else {
            let alert  = UIAlertController(title: "SET BULLSEYE!", message: "Please set BullsEye parameters on the Bulls Eye Page before exporting the overlay", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    //Text Fields
    @IBOutlet weak var threatNameTextField: UITextField!
    @IBOutlet weak var threatRangeTextField: UITextField!
    @IBOutlet weak var threatBearingTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == threatNameTextField {
            threatRangeTextField.becomeFirstResponder()
        } else if textField == threatRangeTextField {
            threatBearingTextField.becomeFirstResponder()
        } else {
            threatBearingTextField.resignFirstResponder()
        }
        return true
    }
    let ColorArray = ["Red",
                      "Black",
                      "Orange",
                      "Dark Yellow",
                      "Yellow",
                      "Dark Green",
                      "Light green",
                      "Dark Blue",]
    
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
        Variables.UI_threatColor = ColorArray[row]
    }
    
    
    //Location Services
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
        if let location = didUpdateLocations.first {
            _ = location
            
            //print("Lattitude:  \(location.coordinate.latitude)")
            //print("Longitude:  \(location.coordinate.longitude)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let BE_CenterPointDefault = UserDefaults.standard.object(forKey: "BE_centerPoint") {
            print(BE_CenterPointDefault)
        }
        if let coordsCalculated = UserDefaults.standard.object(forKey: "coordsCalculated"){
            Variables.BE_centerPointCalculatedArray = coordsCalculated as! [Double]
            print(Variables.BE_centerPointCalculatedArray)
        }
        
        
        if let threatArray = UserDefaults.standard.object(forKey: "threats") {
            threats = threatArray as! Array
            threatsTable.reloadData()
        }
        if let threatDic = UserDefaults.standard.object(forKey: "threatDictionary") {
            threatDictionary = threatDic as! Dictionary
        }
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
