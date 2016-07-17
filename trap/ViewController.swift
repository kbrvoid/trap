//
//  ViewController.swift
//  trap
//
//  Created by Kabir Shah on 7/16/16.
//  Copyright © 2016 Kabir Shah. All rights reserved.
//

import UIKit
import AudioToolbox
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var deployButton: UIButton!
    
    var locationManager: CLLocationManager!
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "Trap")
    
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
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("check"), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func deployButtonDidClick(sender: UIButton) {
        addTrap(lat!, lon: lon!)
    }
    
    func explode() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        let alert = UIAlertController(title: "It's A Trap!", message: "you were just trapped", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "DEPLOY", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func addTrap(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Trap", inManagedObjectContext: self.managedObjectContext) as! Trap
        
        newItem.lat = lat
        newItem.lon = lon
    }
    
    func check() {
        do {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Trap]
            for result in fetchResults! as [Trap] {
                if result.lat == lat && result.lon == lon {
                    explode()
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
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

