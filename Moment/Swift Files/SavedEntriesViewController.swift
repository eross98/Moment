//
//  ViewControllerTest.swift
//  Moment
//
//  Created by Evan Ross on 8/6/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import CoreData


class SavedEntriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: Any) {
        print("Added to the coreData")

        let newEntry = Entry(context: self.context)
        newEntry.dayInt = 8
        newEntry.dayString="Monday"
        newEntry.month = 7
        newEntry.time = 15
        newEntry.year = 2020
        
        do{
            try self.context.save()
            print("Added to the coreData")
        }
        catch{
            print("Error in saving to CoreData")
        }
        self.fetch()
    }
    
    var arrayEntries:[Entry]!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tempThing()
        }
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
    
    func tempThing()
    {
        let newEntry = Entry(context: self.context)
        newEntry.dayInt = 8
        newEntry.dayString="Monday"
        newEntry.month = 7
        newEntry.time = 15
        newEntry.year = 2020
        
        do{
            try self.context.save()
        }
        catch{
            print("Error in saving to CoreData")
        }
        self.fetch()
    }
    
    func fetch()
    {
        do{
            try self.arrayEntries = context.fetch(Entry.fetchRequest())
            tableView.reloadData()
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch{
            print("Error getting the objects form coredata")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let temp = arrayEntries[indexPath.row]
        print(arrayEntries.count)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SavedCell
        cell.setCell(entry: temp)
        
        return cell
    }
}
