//
//  ViewController.swift
//  Location
//
//  Created by elmo on 1/25/18.
//  Copyright © 2018 Caerus. All rights reserved.
//

// < # placeholder_text/code #>

import UIKit
import CoreLocation
import CoreMotion
import AVFoundation


class POIViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource  {
    

    var HUD_ColorBool: Bool = false
    func HUD_Color() {
        if self.HUD_ColorBool == true {
            crossHairImage.image = #imageLiteral(resourceName: "HUDRedThin")
            pilotHUDSideLabel.textColor = UIColor.HUDred
            headingToTargetLabel.textColor = UIColor.HUDred
            distanceToTargetLabel.textColor = UIColor.HUDred
            targetLatLabel.textColor = UIColor.HUDred
            targetLongLabel.textColor = UIColor.HUDred
            
            targetToBullsEyeDisLabel.textColor = UIColor.HUDred
            targetBulsEyeBearingLabel.textColor = UIColor.HUDred
            bullsEyeNameLabel.textColor = UIColor.HUDred
            
            captureButtonOutlet.titleLabel!.textColor = UIColor.HUDred
            clearButtonOutlet.titleLabel!.textColor = UIColor.HUDred
            generateAndExportButtonStyle.titleLabel!.textColor = UIColor.HUDred
        } else {
            crossHairImage.image = #imageLiteral(resourceName: "HUDVBThin")
            pilotHUDSideLabel.textColor = UIColor.vibrantGreen
            headingToTargetLabel.textColor = UIColor.vibrantGreen
            distanceToTargetLabel.textColor = UIColor.vibrantGreen
            targetLatLabel.textColor = UIColor.vibrantGreen
            targetLongLabel.textColor = UIColor.vibrantGreen
            
            targetToBullsEyeDisLabel.textColor = UIColor.vibrantGreen
            targetBulsEyeBearingLabel.textColor = UIColor.vibrantGreen
            bullsEyeNameLabel.textColor = UIColor.vibrantGreen
            
            captureButtonOutlet.titleLabel!.textColor = UIColor.vibrantGreen
            clearButtonOutlet.titleLabel!.textColor = UIColor.vibrantGreen
            generateAndExportButtonStyle.titleLabel!.textColor = UIColor.vibrantGreen
            
        }}
    
    @IBOutlet weak var hudSwitchOutlet: UISwitch!
    @IBAction func hudSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            HUD_ColorBool = false
            HUD_Color()
        } else {
            HUD_ColorBool = true
            HUD_Color()
        }}

    let simulatedAltitude = 70_000.00.feetToMeters
    var POI_Counter = 0
    var latOfDevice = 0.0
    var longOfDevice = 0.0
    var altOfDevice = 0.0
    var pitchAndgleOfDevice = 0.0
    var headingOfDevice = 0.0
    var rollOfDevice = 0.0
    var latOfPOI = 0.0
    var longOfPOI = 0.0
    var POI_FixData = [String:[String]]()
    var bullsEyeKML = String()
    var POI_KML: String = ""
    var setOfCoords = [[String]]()
    var POI_FixDataForTableDisplay = [String]()
    var allCoordsTaken = [Date:[Double]]()
    var poi = PlaceMark()
    var calculation = Calculation()
    
    // MARK: GEN Button
    @IBOutlet weak var generateAndExportButtonStyle: UIButton!
    @IBAction func generateAndExportButton(_ sender: Any) {
        HUD_Color()
        if POI_Counter == 0 {
            let alert  = UIAlertController(title: "No Captured Points", message: "You have not taken any fixes to generate an Overlay. If you would like a Bulls Eye only overlay, please go to the Bulls Eye tab and select the blue target button to the right of the Saved Bulls Eye information", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        } else {
            if let x = UserDefaults.standard.object(forKey: "BullsEye") {
                bullsEyeKML = x as! String
                let internalKML = "\(POI_KML),\(bullsEyeKML)"
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
            }}}

    // MARK: - Table Items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return POI_FixDataForTableDisplay.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        }
        cell!.textLabel?.text = POI_FixDataForTableDisplay[indexPath.row]
        return cell!
    }
    
    

//    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

    // MARK: HUD items
    @IBOutlet var coordTable: UITableView!
    @IBOutlet var crossHairImage: UIImageView!
    @IBOutlet var captureButtonOutlet: UIButton!
    @IBOutlet weak var headingToTargetLabel: UILabel!
    @IBOutlet weak var distanceToTargetLabel: UILabel!
    @IBOutlet weak var clearButtonOutlet: UIButton!
    
    
    @IBOutlet weak var targetLatLabel: UILabel!
    @IBOutlet weak var targetLongLabel: UILabel!
    
    
    @IBOutlet weak var hudItemsStackView: UIStackView!
    @IBOutlet weak var hudItemsBEStackView: UIStackView!
    @IBOutlet weak var targetToBullsEyeDisLabel: UILabel!
    @IBOutlet weak var targetBulsEyeBearingLabel: UILabel!
    @IBOutlet weak var bullsEyeNameLabel: UILabel!
    @IBOutlet weak var pilotHUDSideLabel: UILabel!
    
    
    // MARK: - Camera Items
    let captureCoords = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    var cameraPreview: AVCaptureVideoPreviewLayer?
    func selectInputDevice() {
        let devices = AVCaptureDevice.default(for: AVMediaType.video)
        if devices?.position == AVCaptureDevice.Position.back {
            backCamera = devices
        }
        currentDevice = backCamera
        do {
            if let currentDevice = currentDevice {
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
                captureCoords.addInput(captureDeviceInput)
            }}
        catch {
            print(error.localizedDescription)
        }}
    func beginCamera(){
        cameraPreview = AVCaptureVideoPreviewLayer(session: captureCoords)
        view.layer.addSublayer(cameraPreview!)
        view.bringSubview(toFront: hudSwitchOutlet)
        view.bringSubview(toFront: pilotHUDSideLabel)
        view.bringSubview(toFront: bullsEyeNameLabel)
        view.bringSubview(toFront: hudItemsBEStackView)
        view.bringSubview(toFront: targetToBullsEyeDisLabel)
        view.bringSubview(toFront: targetBulsEyeBearingLabel)
        view.bringSubview(toFront: headingToTargetLabel)
        view.bringSubview(toFront: hudItemsStackView)
        view.bringSubview(toFront: distanceToTargetLabel)
        view.bringSubview(toFront: targetLatLabel)
        view.bringSubview(toFront: targetLongLabel)
        view.bringSubview(toFront: rollInformationLabel)
        view.bringSubview(toFront: rollFixLabel)
        view.bringSubview(toFront: buttonStack)
        view.bringSubview(toFront: crossHairImage)
        view.bringSubview(toFront: captureButtonOutlet)
        view.bringSubview(toFront: coordTable)
        cameraPreview?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreview?.frame = view.layer.bounds
        captureCoords.startRunning()
    }

    //Apply Protocol : CLLocationManagerDelegate
    // MARK: - Pitch, Roll, Yaw
    let motionManager = CMMotionManager()
    func outputRPY(data: CMDeviceMotion){
        let rpyattitude: CMAttitude
        let roll: Double
        let pitch: Double
        if let rpy = motionManager.deviceMotion {
            rpyattitude = rpy.attitude
            roll    = rpyattitude.roll * (180.0 / Double.pi)
            rollOfDevice = rpyattitude.roll * (180.0 / Double.pi)
            pitch   = rpyattitude.pitch * (180.0 / Double.pi)
            self.pitchAndgleOfDevice = pitch
            if abs(roll) > 2 {
                rollFixLabel.layer.backgroundColor = UIColor.red.cgColor
                rollFixLabel.layer.borderWidth = 5
                rollFixLabel.text  = "\(String(format: "%.0f°", roll))"
            } else {
                rollFixLabel.layer.borderWidth = 5
                rollFixLabel.layer.backgroundColor = UIColor.green.cgColor
                rollFixLabel.text  = "\(String(format: "%.0f°", roll))"
            }}}
    
    func getOrientation(){
        motionManager.deviceMotionUpdateInterval = 0.01
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motionData: CMDeviceMotion?, NSError) -> Void in self.outputRPY(data: motionData!)
            if (NSError != nil){
                //print("\(String(describing: NSError))")
        }})}
    //Apply Protocol : CLLocationManagerDelegate
    // MARK: - Lattitude, Longitude, Altitude, Heading and more.
    let locManager = CLLocationManager()
    // Heading readings tend to be widely inaccurate until the system has calibrated itself
    // Return true here allows iOS to show a calibration view when iOS wants to improve itself
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    // This function will be called whenever your heading is updated.
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.headingOfDevice = newHeading.trueHeading
        // MARK: HUD Calculations
        headingToTargetLabel.text = "\(String(format: "%.0f", headingOfDevice))°"
        if let location = locManager.location {
            let deviceLat = location.coordinate.latitude
            let deviceLong = location.coordinate.longitude
            let deviceAlt = location.altitude
            let devicePitch = pitchAndgleOfDevice.degreesToRadians
            let deviceHeading = headingOfDevice
            let targetDistance = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: deviceLat, longitudeAngleOfDevice: deviceLong, altitudeOfDevice: deviceAlt, pitchAngleOfTheDevice: devicePitch, headingAngleOfTheDevice_TN: deviceHeading)[2]
            let targetLat = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: deviceLat, longitudeAngleOfDevice: deviceLong, altitudeOfDevice: deviceAlt, pitchAngleOfTheDevice: devicePitch, headingAngleOfTheDevice_TN: deviceHeading)[0]
            let targetLong = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: deviceLat, longitudeAngleOfDevice: deviceLong, altitudeOfDevice: deviceAlt, pitchAngleOfTheDevice: devicePitch, headingAngleOfTheDevice_TN: deviceHeading)[1]
            if Variables.BE_Name != "xx BE NAME xx" || Variables.BE_centerPoint != "38.30943N/88.00854W" {
                bullsEyeNameLabel.text = Variables.BE_Name
                if let BE_point = Variables.BE_centerPoint {
                    let BE_Lat = BE_point.coordTranslate()[0]
                    let BE_Long = BE_point.coordTranslate()[1]
                    let targetToBEDistance_NM = calculation.rangeAndBearing(latitude_01: BE_Lat, longitude_01: BE_Long, latitude_02: targetLat, longitude_02: targetLong)[0]
                    let bearingToTargetFromBE = calculation.rangeAndBearing(latitude_01: BE_Lat, longitude_01: BE_Long, latitude_02: targetLat, longitude_02: targetLong)[1]
                    targetToBullsEyeDisLabel.text = "\(String(format: "%.2f", targetToBEDistance_NM)) NM"
                    targetBulsEyeBearingLabel.text = "\(String(format: "%.0f", bearingToTargetFromBE))°"
                    Variables.POI_rangeFromBE = targetToBEDistance_NM
                    Variables.POI_bearingFromBE = bearingToTargetFromBE
                } else {
                    bullsEyeNameLabel.text = ""
                    targetToBullsEyeDisLabel.text = ""
                    targetBulsEyeBearingLabel.text = ""
                }
            }
            distanceToTargetLabel.text = "\(String(format: "%.2f", targetDistance)) NM"
            targetLatLabel.text = targetLat.lat_DDdddd_To_DDMMdd()
            targetLongLabel.text = targetLong.long_DDdddd_To_DDMMdd()
            Variables.POI_currentDistanceFromDevice = targetDistance
            Variables.POI_currentHeadingFromDevice = deviceHeading
            Variables.POI_latitude = targetLat
            Variables.POI_longitude = targetLong
        }

        let trueHeading = newHeading.trueHeading
        let magHeading = newHeading.magneticHeading
        // MARK: MagneticVariation Calculation
        Variables.UserMagVariation = trueHeading - magHeading
        //UserDefaults.standard.set(Variables.UserMagVariation, forKey: "UserMagVariation")
        //print(Variables.UserMagVariation)
    }

    // call the below function in viewDidLoad()
    func getpositionPermission(){
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.headingFilter = kCLHeadingFilterNone
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.headingOrientation = .portrait
        locManager.delegate = self
        locManager.startUpdatingHeading()
        locManager.startUpdatingLocation()
    }
 
    // MARK: - CaptureButton
    @IBAction func captureCoordsButton(_ sender: UIButton) {
        HUD_Color()
        getPosition()
        if abs(rollOfDevice) > 2 {
            rollInformationLabel.text = "Roll must be ±2°"
           // rollInformationLabel.layer.backgroundColor = UIColor.darkGray.cgColor
            rollInformationLabel.layer.cornerRadius = 3
        } else {
            rollInformationLabel.text = ""
            // MARK: POI Calculations
            let POI_Lat = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: altOfDevice, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[0]
            let POI_Long = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: altOfDevice, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[1]
            let POI_Dis = calculation.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: altOfDevice, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[2]
       
            POI_Counter += 1
            POI_FixDataForTableDisplay.append("\(POI_Counter)")


//            POI_FixDataForTableDisplay.append("""
//                POI: \(POI_Counter)
//                Lat: \(String(format: "%.3f", POI_Lat)):
//                Long: \(String(format: "%.3f", POI_Long)):
//                Bearing: \(String(format: "%.0f", headingOfDevice))°
//                Range: \(String(format: "%.1f", POI_Dis))
//                """)
            
            POI_FixData.updateValue([String(POI_Lat),String(POI_Long), String(headingOfDevice), String(POI_Dis)], forKey: String(POI_Counter))
            print(POI_FixDataForTableDisplay)
            coordTable.reloadData()
            poi.placeMarkTitle = String(POI_Counter)
            poi.placeMarkPOICoords = [POI_FixData[String(POI_Counter)]![1],POI_FixData[String(POI_Counter)]![0]]
            POI_KML += poi.placeMarkGeneratorWithPreCalcCoords()
            print(POI_KML)
        }
    }
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBAction func clearTableButtong(_ sender: UIButton) {
        HUD_Color()
        rollInformationLabel.text = ""
        POI_Counter = 0
        POI_FixDataForTableDisplay.removeAll()
        coordTable.reloadData()
    }
    // call the below function in viewDidLoad()
    func getPosition(){
        if let location = locManager.location {
            let latt = location.coordinate.latitude
            let long = location.coordinate.longitude
            let alt = location.altitude // in meters
            self.latOfDevice = latt
            self.longOfDevice = long
            self.altOfDevice = alt
        }}
    
    @IBOutlet weak var rollInformationLabel: UILabel!
    @IBOutlet weak var rollFixLabel: UILabel!
    
    // MARK: ViewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD_Color()
        
        rollFixLabel.layer.cornerRadius = 20
        getpositionPermission()
        getOrientation()
        getPosition()
        selectInputDevice()
        beginCamera()
        coordTable.delegate = self
        coordTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

