//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jason Malia on 6/29/16.
//  Copyright © 2016 Jason malia. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordButton.isEnabled = true
        recordButton.isHidden = false
        stopRecordingButton.isEnabled = false
        stopRecordingButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        recordButton.isEnabled = false
        recordButton.isHidden = true
        stopRecordingButton.isEnabled = true
        stopRecordingButton.isHidden = false
        recordingLabel.text = "Recording in progress..."
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        print(audioRecorder.url)
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        audioRecorder.stop()
        recordButton.isEnabled = true
        recordButton.isHidden = false
        stopRecordingButton.isEnabled = false
        stopRecordingButton.isHidden = true
        recordingLabel.text = "Record!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

