//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Ramit sharma on 22/01/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import UIKit

class CurrentRunVC: LocationVC {
    @IBOutlet weak var swipeBgImg: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!
    @IBOutlet weak var endRunLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImg.addGestureRecognizer(swipeGesture)
        sliderImg.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
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
