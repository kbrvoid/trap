//
//  ViewController.swift
//  trap
//
//  Created by Gopal Shah on 7/16/16.
//  Copyright © 2016 Kabir Shah. All rights reserved.
//

import UIKit
import AudioToolbox
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var deployButton: UIButton!
    
    var locationManager: CLLocationManager!
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button Setup
        deployButton.backgroundColor = UIColor.clearColor()
        deployButton.layer.borderWidth = 1
        deployButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // Monitor Location
        self.locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        print(managedObjectContext)
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("check"), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func deployButtonDidClick(sender: UIButton) {
        
    }
    
    func explode() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        let alert = UIAlertController(title: "It's A Trap!", message: "you were just trapped", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "DEPLOY", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func addTrap(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
    }
    
    func check() {
        if lat == CLLocationDegrees(37.785834) && lon == CLLocationDegrees(-122.406417) {
            explode()
        }
    }
    
    func locationManager(manager: CLLocationManager,   didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lat = locValue.latitude
        lon = locValue.longitude
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
