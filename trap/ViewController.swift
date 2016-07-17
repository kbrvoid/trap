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
    var limit: Int?
    var trapLocations: [Trap]?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
    
    // When Button Is Clicked
    @IBAction func deployButtonDidClick(sender: UIButton) {
        addTrap(lat!, lon: lon!)
    }
    
    
    
    
    
    
    // Function - Displays alert and vibrates phone
    func explode(i: Int) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        let alert = UIAlertController(title: "It's A Trap!", message: "you were just trapped", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "DEPLOY", style: UIAlertActionStyle.Default, handler: nil))
        
        // Show alert
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    
    
    
    
    // Function - Utility to help add Trap's easily
    func addTrap(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Trap", inManagedObjectContext: self.managedObjectContext) as! Trap
        
        newItem.lat = lat
        newItem.lon = lon
    }
    
    
    
    
    // Function - Runs every second checking if user is on a trap
    func check() {
        fetchTrap()
        for (index, result) in trapLocations!.enumerate() {
            if result.lat == lat && result.lon == lon {
                managedObjectContext.deleteObject(trapLocations![index])
                explode(index)
            }
        }
    }
    
    
    
    
    
    // Function - Location Manager will update lat and lon variables with users coordinates
    
    func locationManager(manager: CLLocationManager,   didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lat = locValue.latitude
        lon = locValue.longitude
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    
    
    
    
    
    // Function - Utility to fetch traps from Core Data
    func fetchTrap() -> [Trap]? {
        do {
            let fetchRequest = NSFetchRequest(entityName: "Trap")
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Trap]
            trapLocations = fetchResults!
            return trapLocations!
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    


}

