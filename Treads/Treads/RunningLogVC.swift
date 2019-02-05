//
//  RunningLogVC.swift
//  Treads
//
//  Created by Ramit sharma on 16/01/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import UIKit

class RunningLogVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }


}
extension RunningLogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
            guard let run = Run.getAllRuns()?[indexPath.row]
                else {
                    return RunLogCell()
        }
            cell.configure(run: run)
            return cell
        } else {
            return RunLogCell()
            
        }
        
    }
    
}

