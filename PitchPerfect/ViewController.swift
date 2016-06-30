//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jason Malia on 6/29/16.
//  Copyright © 2016 Jason malia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        recordButton.enabled = false
        recordButton.hidden = true
        stopRecordingButton.enabled = true
        stopRecordingButton.hidden = false
        recordingLabel.text = "Recording in progress..."
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordButton.enabled = true
        recordButton.hidden = false
        stopRecordingButton.enabled = false
        stopRecordingButton.hidden = true
        recordingLabel.text = "Tap to record"
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        recordButton.hidden = false
        stopRecordingButton.enabled = false
        stopRecordingButton.hidden = true
    }
}

