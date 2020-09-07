//
//  ViewController.swift
//  Moment
//
//  Created by Evan on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    var timeMed = 10
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var timeMeditate: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        print("Added")
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
    }
    
    

    @IBAction func sliderAction(_ sender: UISlider) {
        timeMed = Int(sender.value)
        if timeMed == 1{
            timeMeditate.text = String(timeMed) + " Minute"
        }
        else {
            timeMeditate.text = String(timeMed) + " Minutes"
        }
    }
    
    
    @IBAction func startAction(_ sender: Any) {
    performSegue(withIdentifier: "timer", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timer"{
            let vc = segue.destination as! ViewControllerTimer
            vc.modalPresentationStyle = .fullScreen
        
            //Add the song to play here for a future addition
            vc.timeInput = Int(timeMed)
        }
        else{
            return
        }
       
    }
    
    @IBAction func SavedAction(_ sender: Any) {
        
        performSegue(withIdentifier: "segueSaved", sender: self)
    }
    
}

