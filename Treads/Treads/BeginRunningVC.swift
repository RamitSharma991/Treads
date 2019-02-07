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
        print("here are all my runs \(Run.getAllRuns())")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        myMapView.delegate = self
        manager?.startUpdatingLocation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func setUpMapView() {
        if let overlay = addLastRunToMap() {
            if myMapView.overlays.count > 0 {
                myMapView.removeOverlay(myMapView?.overlays as! MKOverlay)
            }
            myMapView.addOverlay(overlay)
            lastRunStack.isHidden = false
            lastRunBGView.isHidden = false
            lastRunCloseBtn.isHidden = false

        } else {
            
            lastRunStack.isHidden = true
            lastRunBGView.isHidden = true
            lastRunCloseBtn.isHidden = true
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2))"
        DurationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinates = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        return MKPolyline(coordinates: coordinates, count: lastRun.locations.count)
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}
