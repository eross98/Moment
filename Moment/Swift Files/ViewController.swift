//
//  ViewController.swift
//  Moment
//
//  Created by Evan on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timeMed = 10
    
    @IBOutlet weak var timeMeditate: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        timeMed = Int(sender.value)
        timeMeditate.text = String(timeMed) + " Minutes"
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

