//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jason Malia on 6/29/16.
//  Copyright © 2016 Jason malia. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecoder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordButton.enabled = true
        recordButton.hidden = false
        stopRecordingButton.enabled = false
        stopRecordingButton.hidden = true
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
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecoder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecoder.meteringEnabled = true
        audioRecoder.prepareToRecord()
        audioRecoder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordButton.enabled = true
        recordButton.hidden = false
        stopRecordingButton.enabled = false
        stopRecordingButton.hidden = true
        recordingLabel.text = "Tap to record"
    }
    
    override func viewWillAppear(animated: Bool) {
    }
}

