//
//  FirstViewController.swift
//  MyLocations
//
//  Created by sytar on 16/4/27.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit
import CoreLocation


class CurrentLocationViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    @IBAction func getLocation() {
        
        let authStatus: CLAuthorizationStatus =
        CLLocationManager.authorizationStatus()
        
        if authStatus == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .Denied || authStatus == .Restricted{
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation{
            stopLocationManager()
        }else{
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        updateLabels()
        configerGetButton()
    }
    
    var location:CLLocation?
    
    var updatingLocation = false
    var lastLocationError: NSError?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        configerGetButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - showLocationServicesDeniedAlert
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",
            message:
            "Please enable location services for this app in Settings.",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default,
            handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(locationManager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
            
            print("didUpdateLocations \(locations.last)")
            
            if let newLocation = locations.last{
            
                if newLocation.timestamp.timeIntervalSinceNow < -5 {
                    return
                }
            
                if newLocation.horizontalAccuracy < 0{
                    return
                }
            
                if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy{
                
                lastLocationError = nil
                location = newLocation
                updateLabels()
                    if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy{
                        print("We are done!")
                        stopLocationManager()
                        configerGetButton()
                    }
                }

            }
    }
    
    func locationManager(locationManager: CLLocationManager,
        didFailWithError error: NSError){
            print("didFailWithError \(error)")
            if error.code == CLError.LocationUnknown.rawValue{
                return
            }
            lastLocationError = error
            stopLocationManager()
            updateLabels()
            configerGetButton()
    }
    
    func updateLabels(){
        if let location = self.location{
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.hidden = false
            messageLabel.text = ""
        }else{
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.hidden = true
            messageLabel.text = "Tap 'Get My Location' to Start"
            var statusMessage: String
            if let error = lastLocationError {
                if error.domain == kCLErrorDomain &&
                    error.code == CLError.Denied.rawValue {
                        statusMessage = "Location Services Disabled"
                } else {
                    statusMessage = "Error Getting Location"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            } else if updatingLocation {
                statusMessage = "Searching..."
            } else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            messageLabel.text = statusMessage
        }
    }
    
    func startLocationManager(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocationManager(){
        if updatingLocation{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func configerGetButton(){
        if updatingLocation{
            getButton.setTitle("STOP", forState: UIControlState.Normal)
        }else{
            getButton.setTitle("Get My Location", forState: UIControlState.Normal)
        }
    }


}

