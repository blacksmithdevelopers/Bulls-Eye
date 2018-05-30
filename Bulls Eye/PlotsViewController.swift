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
    var bullsEyeCenterPointArray: [Double] = []
    var threatKML: String = ""
    var threatLabel: String = ""
    var threatColor = "Red"
    
    var threats = [""]
    var threatDictionary = [String: Array<Any>]()

    var popUpThreatRingRadius: Double = 80.0
    var popUpThreatLocation: [Double] = [0.0, 0.0]
    
    var foreFlightPolyGon_KML = ""
    var clipBoardCounter = 0
    
    @IBOutlet weak var foreFlightButtonOutlet: UIButton!
    @IBAction func foreFlightButton(_ sender: UIButton) {
        if let listOfPoints = pasteFromForeflight().importFlightPlanFromForeflight()["Clip Board"] {
            clipBoardCounter += 1
            let pathID = "Clip Board"
            let path = PolygonClass()
            path.styleName = pathID
            path.name = pathID
            path.foreFlightCoords = listOfPoints
            let foreFlightStyle = Style()
            foreFlightStyle.name = pathID
            foreFlightStyle.color = "Red"
            let foreFlightStyle_KML = foreFlightStyle.styleGenerator()
            let foreFlight_KML = foreFlightStyle_KML + path.foreFlightPolygonGenerator(listOfPoints)
            print(foreFlight_KML)
            threatKML += foreFlight_KML
            //print(threatKML)
            threats.append("\(pathID)_\(String(clipBoardCounter))")
            threatsTable.reloadData()
            UserDefaults.standard.set(threats, forKey: "threats")
            UserDefaults.standard.set(threatDictionary, forKey: "threatDictionary")
        } else {
            let alertController = UIAlertController(title: "Please Send to ClipBoard", message:
                "This button takes a foreflight flightplan (coordinate points) from the clipboard and creates a KML Overlay item. Please try again", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        }
        
    }
    
    func pasteFromForeflight() -> String {
        let pasteBoard = UIPasteboard.general
        var FF = ""
        if let fromFF = pasteBoard.string {
            FF = fromFF
            if FF.suffix(2) == "ft" {
                return fromFF
            } else {
                let alertController = UIAlertController(title: "Please Send to ClipBoard", message:
                    "This button takes a foreflight flightplan (coordinate points) from the clipboard and creates a KML Overlay item. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            }
        } else {
            print("Nothing copied")
        }
        return FF
        
    }

    
    
    
    // MARK: PopUp Threat information
    @IBOutlet weak var popUpThreatRadiusLabel: UILabel!
    @IBOutlet weak var popUpThreatStepperOutlet: UIStepper!
    @IBAction func popUpThreatStepper(_ sender: UIStepper) {
        popUpThreatRingRadius = sender.value
        popUpThreatRadiusLabel.text = String(format: "%.0f",popUpThreatRingRadius)
        
    }
    @IBOutlet weak var popUpThreatCenterPointTextField: UITextField!
    
    
    
    //Table
    @IBOutlet weak var threatsTable: UITableView!
//    var threats = [""]
//    var threatDictionary = [String: Array<Any>]()
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
    
    // MARK: SAVE Threat Button
    @IBOutlet weak var saveThreatButtonStyle: UIButton!
    @IBAction func saveThreatButton(_ sender: Any) {
        if (threatNameTextField.text == "" && popUpThreatCenterPointTextField.text == "") || threatNameTextField.text == "" || popUpThreatCenterPointTextField.text == "" {
            let alert  = UIAlertController(title: "Missing Information", message: "Please enter a name for the Threat and Coordinates in the proper format", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let popUpThreat = Circle()
            let threatColor = Variables.UI_threatColor
            Variables.UI_threatName = threatNameTextField.text!
            let threatName = Variables.UI_threatName
            popUpThreat.centerLabelTitle = Variables.UI_threatName
            popUpThreat.styleName = threatName
            if let popUpThreatCenterPoint = (popUpThreatCenterPointTextField.text) {
                popUpThreat.centerPoint = popUpThreatCenterPoint
            } else {
                print("No CenterPoint")
            }
            popUpThreat.radius = Variables.UI_popUpThreatRadius
            Variables.UI_popUpThreatRadius = popUpThreatRingRadius
            
            let popUpThreat_KML = popUpThreat.circleGenerator()
            let popUpThreatPlacemark_KML = popUpThreat.circleCenterLabelGenerator()
            
            let popUpThreatStyle = Style()
            popUpThreatStyle.name = threatName
            popUpThreatStyle.color = threatColor
            let popUpThreatStyle_KML = popUpThreatStyle.styleGenerator()
            let threatKML_All = popUpThreat_KML + popUpThreatPlacemark_KML + popUpThreatStyle_KML
            
            threatKML += threatKML_All
            threats.append(threatName)
            
            threatDictionary[threatName] = [threatName, threatColor, Variables.UI_popUpThreatRadius, popUpThreat.centerPoint, threatKML_All]
            
            threatsTable.reloadData()
            UserDefaults.standard.set(threats, forKey: "threats")
            UserDefaults.standard.set(threatDictionary, forKey: "threatDictionary")
            
        }
    }
    @IBAction func clearAllThreatsButtons(_ sender: Any) {
        clipBoardCounter = 0
        threats.removeAll()
        threatDictionary.removeAll()
        threatsTable.reloadData()
        UserDefaults.standard.set(threats, forKey: "threats")
        UserDefaults.standard.set(threatDictionary, forKey: "threatDictionary")
        threatKML = ""
    }
    
    // MARK: ShareSheet
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == threatNameTextField {
            popUpThreatCenterPointTextField.becomeFirstResponder()
        } else {
            popUpThreatCenterPointTextField.resignFirstResponder()
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
        
        popUpThreatRadiusLabel.text = String(format: "%.0f",popUpThreatRingRadius)
        
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
