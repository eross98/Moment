//
//  ViewControllerTimer.swift
//  Moment
//
//  Created by Evan on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewControllerTimer: UIViewController {

    @IBOutlet weak var timeRemain: UILabel!
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var endOutlet: UIButton!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var timeInput:Int = 0
    var audioTrack = 1
    
    var minute:Int = 10
    var second:Int = 0
    var pauseBool:Bool = false
    var timer:Timer = Timer()
    
    var monthTemp = 0
    var dayIntTemp = 0
    var dayStringTemp = ""
    var yearTemp = 0
    
    
    var player:AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemain.text = String(timeInput) + ":00"
        minute = timeInput - 1
        second = 59
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondTimer), userInfo: nil, repeats: true)
        
        startAudio()
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        sender.pulsatesmall()
        pauseAudio()
        
        //Second time clicking so it will resume the timer and audio
        if (self.pauseBool == true){
            pauseOutlet.setTitle("PAUSE", for: .normal)
            endOutlet.isHidden = true
            pauseBool = false
            player!.play()
            
            
            //restarts the timer and that will also start the audio back up
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondTimer), userInfo: nil, repeats: true)
            
        }
        
        //This would be the first time so it will pause and show the end button
        else{
            pauseBool = true
            pauseAudio()
            pauseOutlet.setTitle("RESUME", for: .normal)
            endOutlet.isHidden = false
        }
    }
    
    @IBAction func endAction(_ sender: UIButton) {
        sender.pulsatesmall()
        stopAudio()
        getDate()
        if self.minute == self.timeInput || self.timeInput == (self.minute + 1){
            //They stopped the timer before a minute so dont bother trying to save
            self.endMe()
        }
        let alert = UIAlertController(title: "Do you want to save your current session", message: "", preferredStyle: .alert)
        let saveMe = UIAlertAction(title: "Save", style: .default){ (action) in
            let newEntry = Entry(context: self.context)
            newEntry.dayInt = Int64(self.dayIntTemp)
            newEntry.dayString=self.dayStringTemp
            newEntry.month = Int64(self.monthTemp)
            newEntry.year = Int64(self.yearTemp)
            
        if self.second == 0{
            newEntry.time = Int64(self.timeInput - self.minute)
        }else{
            newEntry.time = Int64(self.timeInput - self.minute - 1)
        }
            
        do{
            try self.context.save()
        }
        catch{
            print("Error in saving to CoreData")
        }
        self.endMe()
            
            //Enter the code to save the data to core data
        }
        let deleteMe = UIAlertAction(title: "Discard", style: .destructive) { (action) in
            self.endMe()
        }
        
        alert.addAction(deleteMe)
        alert.addAction(saveMe)
        present(alert,animated: true, completion: nil)
    }
    
    //Reduces the second and will present the data to the timer
    @objc func secondTimer()
    {
        if (second == 0){
            if (minute == 0){
                timeRemain.text = "0:00"
                stopAudio()
                timer.invalidate()
                getDate()
                saveMe()
                endMe()
            }
            
            timeRemain.text = String(minute) + ":00"
            minute -= 1
            second = 59
            

        }
        else //second is not zero
        {
            
            var secondString = String(second)
            if(second < 10){
                secondString = "0" + secondString
            }
            timeRemain.text = String(minute) + ":" + secondString
            second -= 1
        }
    }
    
    func startAudio()
    {
        var songString = Bundle.main.path(forResource: "audio1", ofType: "mp3")
        if audioTrack == 2{
            songString = Bundle.main.path(forResource: "audio2", ofType: "mp3")
        }
        else if audioTrack == 3{
            songString = Bundle.main.path(forResource: "audio3", ofType: "mp3")
        }
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .longForm)

            guard let songString = songString else {
                print("Error in getting the string")
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: songString))
            guard let player = player else{
                print("Error getting the player")
                return
            }
            player.play()
            player.numberOfLoops = -1 //Will allow to loop the audio
        }
        catch{
            print("Error in getting the audio")
        }
    }
    
    func pauseAudio()
    {
        timer.invalidate()
        player!.pause()
    }
    
    func stopAudio()
    {
        timer.invalidate()
        player!.stop()
    }
    
    func saveMe()
    {
        let newEntry = Entry(context: self.context)
        newEntry.dayInt = Int64(self.dayIntTemp)
        newEntry.dayString=self.dayStringTemp
        newEntry.month = Int64(self.monthTemp)
        newEntry.year = Int64(self.yearTemp)
        newEntry.time = Int64(self.timeInput)
        do{
            try self.context.save()
        }
        catch{
            print("Error in saving to CoreData")
        }
    }
    
    func endMe()
    {
        backgroundOutlet.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    func getDate()
    {
        //var monthTemp = 0
        //var dayStringTemp = ""
        
        let date=Date()
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        let yearComponent = calendar.dateComponents([.year], from: date)
        yearTemp = yearComponent.year!
        
        let monthComp = calendar.dateComponents([.month], from: date)
        monthTemp = monthComp.month!
        
        let dayComp = calendar.dateComponents([.day], from: date)
        dayIntTemp = dayComp.day!
        
        dateFormatter.dateFormat = "EEEE"
        dayStringTemp = dateFormatter.string(from: date)
    }
}
