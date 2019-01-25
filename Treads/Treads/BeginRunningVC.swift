//
//  BeginRunningVC.swift
//  Treads
//
//  Created by Ramit sharma on 16/01/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import UIKit
import MapKit

class BeginRunningVC: LocationVC {
    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        myMapView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        myMapView.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func locationCenterButton(_ sender: Any) {
    }
    
}
extension BeginRunningVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            myMapView.showsUserLocation = true
            myMapView.userTrackingMode = .follow
        }
    }
}
