//
//  ViewControllerTest.swift
//  Moment
//
//  Created by Evan Ross on 8/6/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import CoreData


class SavedEntriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayEntries:[Entry]!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        let test:Entry = 
        
        // Do any additional setup after loading the view.
    }
    
    func fetch()
    {
        do{
            try self.arrayEntries = context.fetch(Entry.fetchRequest())
        }
        catch{
            print("Error getting the objects form coredata")
        }
        
        /*
        Dispatch.queue.async{
            self.tableView.reloadData()
        }
        */
    }
    

}
