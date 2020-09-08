//
//  ViewController.swift
//  Moment
//
//  Created by Evan on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class ViewController: UIViewController {

    var timeMed = 10
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var songPick = 1
    var player:AVAudioPlayer?

    
    @IBOutlet weak var timeMeditate: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    if playPressed == true{
        player!.stop()
        }
    backOutlet.isHidden = true
    pauseOutlet.isHidden = true
    forwardOutlet.isHidden = true
    trackOutlet.isHidden = true
    hidden = true
    playPressed = false
    performSegue(withIdentifier: "timer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timer"{
            let vc = segue.destination as! ViewControllerTimer
            vc.modalPresentationStyle = .fullScreen
        
            //Add the song to play here for a future addition
            vc.timeInput = Int(timeMed)
            vc.audioTrack = songPick
        }
        else{
            return
        }
    }
    
    @IBAction func SavedAction(_ sender: Any) {
        
        performSegue(withIdentifier: "segueSaved", sender: self)
    }
    
    
    //Changing the song
    @IBOutlet weak var backOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var forwardOutlet: UIButton!
    @IBOutlet weak var trackOutlet: UILabel!
    
    let NUMOFSONGS = 3
    var playPressed = false
    @IBAction func backAction(_ sender: Any) {
        backOutlet.pulsate()
        if playPressed == true{
            player!.stop()
            playPressed = false
        }
        if songPick == 1{
            songPick = NUMOFSONGS
            trackOutlet.text = "Audio " + String(songPick)
        }
        else{
            songPick -= 1
            trackOutlet.text = "Audio " + String(songPick)
        }
    }
    @IBAction func playAction(_ sender: Any) {
        pauseOutlet.pulsate()
        if playPressed == false{
            var songString = Bundle.main.path(forResource: "audio1", ofType: "mp3")
            if songPick == 2{
                songString = Bundle.main.path(forResource: "audio2", ofType: "mp3")

            }else if songPick == 3{
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
            playPressed = true
        }
        else{
            player!.stop()
            playPressed = false
        }
        
    }
    @IBAction func forwardAction(_ sender: Any) {
        forwardOutlet.pulsate()
        if playPressed == true{
            player!.stop()
            playPressed = false
        }
        if songPick == NUMOFSONGS{
            songPick = 1
            trackOutlet.text = "Audio " + String(songPick)
        }
        else{
            songPick += 1
            trackOutlet.text = "Audio " + String(songPick)
        }
    }
    var hidden = true
        
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        sender.pulsate()
        trackOutlet.text = "Audio " + String(songPick)
        
        if hidden == true{
            backOutlet.isHidden = false
            pauseOutlet.isHidden = false
            forwardOutlet.isHidden = false
            trackOutlet.isHidden = false
            hidden = false
        }
        else{
            backOutlet.isHidden = true
            pauseOutlet.isHidden = true
            forwardOutlet.isHidden = true
            trackOutlet.isHidden = true
            hidden = true
        }
    }
    
}

