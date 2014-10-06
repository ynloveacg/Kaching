//
//  ViewController.swift
//  test
//
//  Created by Ni Yan on 10/6/14.
//  Copyright (c) 2014 nyan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_after(DISPATCH_TIME_NOW + 3000, dispatch_get_main_queue()) { () -> Void in
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            if (CLLocationManager.locationServicesEnabled()) {
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.startUpdatingLocation()
            }

        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("updated location: \(locations)")
    }


}

