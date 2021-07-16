//
//  ViewController.swift
//  Pomodoro
//
//  Created by Satyam Sovan Mishra on 15/07/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var stopButton: UIButton!
    var secLeft = 25 * 60
    var totalTime = 25 * 60
    var timer = Timer()
    var player: AVAudioPlayer?
    let url = Bundle.main.url(forResource: "sound", withExtension: "mp3")!
    
    //SF Pro Rounded with Bold weight
    let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(.rounded)?.withSymbolicTraits(.traitBold)
    
    override func viewDidLoad() {
        timeLabel.font = UIFont(descriptor: descriptor!, size: 120)
        quoteLabel.font = UIFont(descriptor: descriptor!, size: 50)
        progressView.layer.cornerRadius = 10
        stopButton.isHidden = true
        
        player = try! AVAudioPlayer(contentsOf: url)
    }
    
    
    @IBAction func playPausePressed(_ sender: UIButton) {
//        playPauseButton.setBackgroundImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        quoteLabel.alpha = 0
        stopButton.isHidden = false
        quoteLabel.isHidden = true
        progressView.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @objc func updateTimer() {
        if secLeft > 0 {
//            print("Remaining: \(secLeft / 60) mins and \(secLeft % 60) secs")
//            print(secLeft)
            secLeft -= 1
            timeLabel.text = "\(secLeft / 60):\(secLeft % 60)"
        } else if secLeft == 0 {
            player!.play()
            timer.invalidate()
            timeLabel.text = "Done!"
        }
        progressView.progress = (Float(totalTime) - Float(secLeft)) / Float(totalTime)
    }
    
    
}

