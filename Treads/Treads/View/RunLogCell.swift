//
//  RunLogCell.swift
//  Treads
//
//  Created by Ramit sharma on 05/02/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(run: Run) {
        runDurationLabel.text = run.duration.formatTimeDurationToString()
        totalDistanceLabel.text = "\(run.distance.metersToMiles(places: 2)) mi"
        averagePaceLabel.text = run.pace.formatTimeDurationToString()
        DateLabel.text = run.date.getDateString()
    }


}
