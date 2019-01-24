//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Ramit sharma on 22/01/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import UIKit
import MapKit

class CurrentRunVC: LocationVC {
    @IBOutlet weak var swipeBgImg: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!
    @IBOutlet weak var endRunLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var runDistance: Double = 0.00
    var counter = 0
    var timer = Timer()
    var pace: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImg.addGestureRecognizer(swipeGesture)
        sliderImg.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    func startRun() {
        manager?.stopUpdatingLocation()
        startTimer()
    }
    func endRun() {
        manager?.stopUpdatingLocation()
    }
    
    func startTimer() {
        durationLabel.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        counter += 1
        durationLabel.text = counter.formatTimeDurationToString()
        
    }
    func calculatePace(time seconds: Int, miles: Double) -> String{
        pace = Int(Double(seconds) / miles)
        return pace.formatTimeDurationToString()
    }
    @IBAction func pause(_ sender: Any) {
    }
    
    
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) { 
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 128
        
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                endRunLabel.alpha = 0.2

                if sliderView.center.x >= (swipeBgImg.center.x - minAdjust) && sliderView.center.x <= (swipeBgImg.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                } else if sliderView.center.x >= (swipeBgImg.center.x + maxAdjust) {
                    sliderView.center.x = swipeBgImg.center.x + maxAdjust

                    dismiss(animated: true, completion: nil)

                }
                else {
                    sliderView.center.x = swipeBgImg.center.x - minAdjust
                }
                
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.2) {
                    sliderView.center.x = self.swipeBgImg.center.x - minAdjust
                    self.endRunLabel.alpha = 1

                    //slider swipes back to original position
                }
            }
            }
        }

}

extension CurrentRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = "\(runDistance.metersToMiles(places: 2))"
            if counter > 0 && runDistance > 0 {
                paceLabel.text = calculatePace(time: counter, miles: runDistance.metersToMiles(places: 2))
            }
        }
        lastLocation = locations.last
    }
}

extension Int {
    func formatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600) % 60
        
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02:%02", durationMinutes, durationSeconds)
            } else {
                return String(format: "%02%02:%02", durationHours, durationMinutes, durationSeconds)
            }
        }
        
    }
}
