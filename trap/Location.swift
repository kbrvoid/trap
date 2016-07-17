//
//  Location.swift
//  trap
//
//  Created by Kabir Shah on 7/16/16.
//  Copyright © 2016 Kabir Shah. All rights reserved.
//

import Foundation
import CoreLocation

var locationManager: CLLocationManager!

func locationManager(manager: CLLocationManager,   didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    lat = locValue.latitude
    lon = locValue.longitude
    //print("locations = \(locValue.latitude) \(locValue.longitude)")
    
}