//
//  SavedCell.swift
//  Moment
//
//  Created by Evan on 9/6/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit

class SavedCell: UITableViewCell {

    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTime: UILabel!
    
    var entryAdd:Entry!
    
    func setCell(entry:Entry)
    {
        if Int(entry.time) == 1{
            cellTime.text = String(entry.time) + " Minute"
        }
        else{
            cellTime.text = String(entry.time) + " Minutes"
        }

        cellDate.text = String(entry.month) + "/" + String(entry.dayInt) + "/" + String(entry.year)
    }

    
}
