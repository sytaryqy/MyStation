//
//  FirstViewController.swift
//  MyLocations
//
//  Created by sytar on 16/4/27.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit
import CoreLocation


class CurrentLocationViewController: UIViewController,CLLocationManagerDelegate,LocationDetailsViewControllerDelegate {

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
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        updateLabels()
        configureGetButton()
    }
    
    var location:CLLocation?
    
    var updatingLocation = false
    var lastLocationError: NSError?
    
    let locationManager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: NSError?
    
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        configureGetButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationDetailsViewControllerDidCancel(controller:LocationDetailsViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TagLocation"{
            
            let navigater = segue.destinationViewController as! UINavigationController
            let controller = navigater.topViewController as! LocationDetailsViewController
            controller.delegate = self
            if location != nil{
                controller.coordinate = location!.coordinate
                controller.placemark = self.placemark
            }
            //print("prepareForSegue")
        }
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
                
                var distance = CLLocationDistance(DBL_MAX)
                if let location = location {
                    distance = newLocation.distanceFromLocation(location)
                }
            
                if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy{
                
                lastLocationError = nil
                location = newLocation
                updateLabels()
                    if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy{
                        print("We are done!")
                        stopLocationManager()
                        configureGetButton()
                        
                        if distance > 0 {
                            performingReverseGeocoding = false
                        }
                    }
                    
                    if !performingReverseGeocoding{
                        print("*** Going to geocode")
                        performingReverseGeocoding = true
                        geocoder.reverseGeocodeLocation(location!, completionHandler: {
                            placemarks , error in
                            print("*** Found placemarks: \(placemarks), error: \(error)")
                            
                            self.lastGeocodingError = error
                            if error == nil && placemarks != nil && !placemarks!.isEmpty {
                                self.placemark = placemarks!.last as CLPlacemark?
                            } else {
                                self.placemark = nil
                            }
                            self.performingReverseGeocoding = false
                            self.updateLabels()
                        })
                    }
                    
                } else if distance < 1.0 {
                    let timeInterval = newLocation.timestamp.timeIntervalSinceDate(
                        location!.timestamp)
                    if timeInterval > 10 {
                        print("*** Force done!")
                        stopLocationManager()
                        updateLabels()
                        configureGetButton()
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
            configureGetButton()
    }
    
    func updateLabels(){
        if let location = self.location{
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.hidden = false
            messageLabel.text = ""
            
            if let placemark = placemark {
                addressLabel.text = stringFromPlacemark(placemark)
            } else if performingReverseGeocoding {
                addressLabel.text = "Searching for Address..."
            } else if lastGeocodingError != nil {
                addressLabel.text = "Error Finding Address"
            } else {
                addressLabel.text = "No Address Found"
            }
            
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
            timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "didTimeOut", userInfo: nil, repeats: false)
        }
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        return
            "\(placemark.subThoroughfare) \(placemark.thoroughfare)\n" +
                "\(placemark.locality) \(placemark.administrativeArea) " +
        "\(placemark.postalCode)"
    }
    
    func stopLocationManager(){
        if updatingLocation{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            if let timer = timer{
                timer.invalidate()
            }
        }
    }
    
    func didTimeOut() {
        print("*** Time out")
        if location == nil {
            stopLocationManager()
            lastLocationError = NSError(domain: "MyLocationsErrorDomain",
                code: 1, userInfo: nil)
            updateLabels()
            configureGetButton()
        }
    }
    
    func configureGetButton(){
        if updatingLocation{
            getButton.setTitle("STOP", forState: UIControlState.Normal)
        }else{
            getButton.setTitle("Get My Location", forState: UIControlState.Normal)
        }
    }


}

