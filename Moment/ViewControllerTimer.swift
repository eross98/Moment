//
//  ViewControllerTimer.swift
//  Moment
//
//  Created by Evan on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerTimer: UIViewController {

    @IBOutlet weak var timeRemain: UILabel!
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var endOutlet: UIButton!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    
    
    var timeInput:Int = 0
    var minute:Int = 10
    var second:Int = 0
    var pauseBool:Bool = false
    var timer:Timer = Timer()
    
    var player:AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemain.text = String(timeInput) + ":00"
        minute = timeInput
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondTimer), userInfo: nil, repeats: true)
        
        startAudio()
    }
    
    @IBAction func pauseAction(_ sender: Any) {
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
    
    @IBAction func endAction(_ sender: Any) {
        stopAudio()
        let alert = UIAlertController(title: "Do you want to save your current session", message: "", preferredStyle: .alert)
        let saveMe = UIAlertAction(title: "Save", style: .default){ (action) in
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
                endMe()
            }
            minute -= 1
            second = 59
        }
        else //second is not zero
        {
            var secondString = String(second)
            if(second < 10){
                secondString = "0" + secondString
            }
            second -= 1
                
            timeRemain.text = String(minute) + ":" + secondString
        }
    }
    
    func startAudio()
    {
        let songString = Bundle.main.path(forResource: "audio1", ofType: "mp3")
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
    
    func endMe()
    {
        //Not sure if stopAudio() is needed here
        backgroundOutlet.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
}
