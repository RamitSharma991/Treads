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
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var DurationLbl: UILabel!
    @IBOutlet weak var lastRunBGView: UIView!
    @IBOutlet weak var lastRunStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        myMapView.delegate = self
        print("here are all my runs \(Run.getAllRuns())")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
         manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun() {
    guard let lastRun = Run.getAllRuns()?.first else {
        lastRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseBtn.isHidden = true
        return
        }
        
        lastRunStack.isHidden = false
        lastRunBGView.isHidden = false
        lastRunCloseBtn.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2))"
        DurationLbl.text = lastRun.duration.formatTimeDurationToString()
    }
    
    
    @IBAction func lastRunCloseButtonPressed(_ sender: Any) {
        
        lastRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseBtn.isHidden = true
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
