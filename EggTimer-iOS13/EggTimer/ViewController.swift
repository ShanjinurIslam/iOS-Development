//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let eggTimes = ["Soft":5,"Medium":8,"Hard":12]
    var time:Int?
    var timer = Timer();
    var totalTime:Int?
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var label: UILabel!
    @IBAction func hardnessPressed(_ sender: UIButton) {
        time = 0
        totalTime = 0
        timer.invalidate()
        let hardness = sender.currentTitle!
        time = eggTimes[hardness]!
        totalTime = time
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
    }



    @objc func updateCounter() {
        //example functionality
        if time! > 0 {
            label.text = "\(time!) seconds remaining"
            progressBar.progress = 1 - Float(Float(time!)/Float(totalTime!))
            time! -= 1
        }
        else{
            timer.invalidate()
            label.text = "Done"
            progressBar.progress = 1.0
        }
    }
}
