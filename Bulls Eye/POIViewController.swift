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
    var poi = PlaceMark()
    
    
    
    
    var coordsCalculations = Calculation()
    var setOfCoords = [[String]]()
    var POI_FixDataForTableDisplay = [String]()
    var allCoordsTaken = [Date:[Double]]()
    
    @IBOutlet weak var generateAndExportButtonStyle: UIButton!
    @IBAction func generateAndExportButton(_ sender: Any) {
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
        }
    }
    
    
    
    
    
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
    

    
    // MARK: - Camera Items
    let captureCoords = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
    func selectInputDevice() {
        
        let devices = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if devices?.position == AVCaptureDevice.Position.back {
            backCamera = devices
        }
        currentDevice = backCamera
        do {
            if let currentDevice = currentDevice {
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
                captureCoords.addInput(captureDeviceInput)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func beginCamera(){
        cameraPreview = AVCaptureVideoPreviewLayer(session: captureCoords)
        view.layer.addSublayer(cameraPreview!)
        
        
        view.bringSubview(toFront: rollInformationLabel)
        view.bringSubview(toFront: rollFixLabel)
        view.bringSubview(toFront: buttonStack)
        view.bringSubview(toFront: stackViewOutlet)
        view.bringSubview(toFront: crossHairImage)
        view.bringSubview(toFront: captureButtonOutlet)
        view.bringSubview(toFront: coordTable)
        
        
        cameraPreview?.videoGravity = AVLayerVideoGravityResizeAspectFill
        //cameraPreview?.borderColor = UIColor.red.cgColor
        cameraPreview?.frame = view.layer.bounds
        captureCoords.startRunning()
    }
    
    @IBOutlet var coordTable: UITableView!
    @IBOutlet var stackViewOutlet: UIStackView!
    @IBOutlet var crossHairImage: UIImageView!
    @IBOutlet var captureButtonOutlet: UIButton!

    // MARK: - Pitch, Roll, Yaw
    let motionManager = CMMotionManager()
    func outputRPY(data: CMDeviceMotion){
        let rpyattitude = motionManager.deviceMotion!.attitude
        let roll    = rpyattitude.roll * (180.0 / Double.pi)
        rollOfDevice = rpyattitude.roll * (180.0 / Double.pi)
        let pitch   = rpyattitude.pitch * (180.0 / Double.pi)
        let yaw     = rpyattitude.yaw * (180.0 / Double.pi)
        rollLabel.text  = "Roll: \(String(format: "%.0f°", roll))"
        pitchLabel.text = "Pitch: \(String(format: "%.0f°", pitchAndgleOfDevice))"
        yawLabel.text   = "Yaw: \(String(format: "%.0f°", yaw))"
        self.pitchAndgleOfDevice = pitch
        
        
        
        
        if abs(roll) > 2 {
            rollFixLabel.layer.backgroundColor = UIColor.red.cgColor
            rollFixLabel.layer.borderWidth = 5
            rollFixLabel.text  = "\(String(format: "%.0f°", roll))"
        } else {
            rollFixLabel.layer.borderWidth = 5
            rollFixLabel.layer.backgroundColor = UIColor.green.cgColor
            rollFixLabel.text  = "\(String(format: "%.0f°", roll))"
        }
        
    }
    func getOrientation(){
        motionManager.deviceMotionUpdateInterval = 0.01
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motionData: CMDeviceMotion?, NSError) -> Void in self.outputRPY(data: motionData!)
            if (NSError != nil){
                print("\(String(describing: NSError))")
        }})}
    
    // MARK: - Lattitude, Longitude, Altitude, Heading and more.
    let locManager = CLLocationManager()
    // Heading readings tend to be widely inaccurate until the system has calibrated itself
    // Return true here allows iOS to show a calibration view when iOS wants to improve itself
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    // This function will be called whenever your heading is updated.
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingLabel.text = "Heading: \(String(format: "%.0f", headingOfDevice))"
        self.headingOfDevice = newHeading.trueHeading
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
        getPosition()
        
        if abs(rollOfDevice) > 2 {
            rollInformationLabel.text = "Roll must be ±2°"
            rollInformationLabel.layer.backgroundColor = UIColor.darkGray.cgColor
            rollInformationLabel.layer.cornerRadius = 3
        } else {
            rollInformationLabel.text = ""
            let POI_Lat = coordsCalculations.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: simulatedAltitude, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[0]
            let POI_Long = coordsCalculations.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: simulatedAltitude, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[1]
            let POI_Dis = coordsCalculations.coordsOfPOICalculate(latitudeAngleOfDevice: latOfDevice, longitudeAngleOfDevice: longOfDevice, altitudeOfDevice: simulatedAltitude, pitchAngleOfTheDevice: pitchAndgleOfDevice.degreesToRadians, headingAngleOfTheDevice_TN: headingOfDevice)[2]
            POI_Counter += 1
            POI_FixDataForTableDisplay.append("""
                POI: \(POI_Counter)
                Lat: \(String(format: "%.3f", POI_Lat)):
                Long: \(String(format: "%.3f", POI_Long)):
                Bearing: \(String(format: "%.0f", headingOfDevice))°
                Range: \(String(format: "%.1f", POI_Dis))
                """)
            
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
            
            
            lattitudeLabel.text = "Lat: \(String(format: "%.2f", latt))"
            longitudeLabel.text = "Long: \(String(format: "%.2f", long))"
            altitudeLabel.text = "Alt: \(String(format: "%.2f", alt))"
            

            
            self.latOfDevice = latt
            self.longOfDevice = long
            self.altOfDevice = alt
            
            
        }
    }
    

    
    @IBOutlet weak var rollInformationLabel: UILabel!
    @IBOutlet weak var rollFixLabel: UILabel!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var lattitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var pitchLabel: UILabel!
    @IBOutlet var rollLabel: UILabel!
    @IBOutlet var yawLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rollFixLabel.layer.cornerRadius = 20
        stackViewOutlet.isHidden = true
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

