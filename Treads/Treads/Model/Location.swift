//
//  Location.swift
//  Treads
//
//  Created by Ramit sharma on 06/02/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }

}
