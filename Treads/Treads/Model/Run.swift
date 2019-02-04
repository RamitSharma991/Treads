//
//  Run.swift
//  Treads
//
//  Created by Ramit sharma on 04/02/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import Foundation
import RealmSwift


class Run: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0


    override class func primaryKey() -> String {
        return "id"
    }
    override class func indexedProperties() -> [String] {
        return ["pace","date", "duration"]
    }
    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }
}
