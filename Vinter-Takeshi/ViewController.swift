//
//  ViewController.swift
//  Vinter-Takeshi
//
//  Created by Guillermo Garcia on 5/16/16.
//  Copyright © 2016 Guillermo Garcia. All rights reserved.
//


import UIKit
import AVFoundation
import AssetsLibrary

class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    var index = 2
    
    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    let fileOutput = AVCaptureMovieFileOutput()
    
    var startButtonA, stopButtonA: UIButton!
    var isRecording = false
    
    @IBOutlet weak var startBButton: UIButton!
    @IBOutlet weak var startCButton: UIButton!
    @IBOutlet weak var startAButton: UIButton!
    
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice) as AVCaptureDeviceInput
        self.captureSession.addInput(videoInput)
        let audioInput = try! AVCaptureDeviceInput(device: self.audioDevice) as AVCaptureInput
        self.captureSession.addInput(audioInput);
        
        self.captureSession.addOutput(self.fileOutput)
        
        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession) as AVCaptureVideoPreviewLayer
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.previewView.layer.addSublayer(videoLayer)
        
        self.setupButton()
        self.captureSession.startRunning()
    }
    
    func setupButton(){
        startAButton.layer.cornerRadius = startAButton.frame.width / 2
        startBButton.layer.cornerRadius = startBButton.frame.width / 2
        startCButton.layer.cornerRadius = startCButton.frame.width / 2
//        self.startButtonA = UIButton(frame: CGRectMake(0,0,120,50))
//        self.startButtonA.backgroundColor = UIColor.redColor();
//        self.startButtonA.layer.masksToBounds = true
//        self.startButtonA.setTitle("start", forState: .Normal)
//        self.startButtonA.layer.cornerRadius = 20.0
//        self.startButtonA.layer.position = CGPoint(x: self.view.bounds.width/2 - 70, y:self.view.bounds.height-50)
//        self.startButtonA.addTarget(self, action: #selector(ViewController.onClickStartButton(_:)), forControlEvents: .TouchUpInside)
//        
//        self.stopButtonA = UIButton(frame: CGRectMake(0,0,120,50))
//        self.stopButtonA.backgroundColor = UIColor.grayColor();
//        self.stopButtonA.layer.masksToBounds = true
//        self.stopButtonA.setTitle("stop", forState: .Normal)
//        self.stopButtonA.layer.cornerRadius = 20.0
//        
//        self.stopButtonA.layer.position = CGPoint(x: self.view.bounds.width/2 + 70, y:self.view.bounds.height-50)
//        self.stopButtonA.addTarget(self, action: #selector(ViewController.onClickStopButton(_:)), forControlEvents: .TouchUpInside)
//        
//        self.view.addSubview(self.startButtonA);
//        self.view.addSubview(self.stopButtonA);
    }
    
    @IBAction func startApushed(sender: AnyObject) {
        if !self.isRecording {
            // start recording
            startRecording("videoA.mp4")
            startAButton.backgroundColor = UIColor.grayColor()
        } else {
            fileOutput.stopRecording()
            isRecording = false
            startAButton.backgroundColor = UIColor.redColor()
            
        }
    }
    
    @IBAction func startBpushed(sender: AnyObject) {
        if !self.isRecording {
            // start recording
            startRecording("videoB.mp4")
            startBButton.backgroundColor = UIColor.grayColor()
        } else {
            fileOutput.stopRecording()
            isRecording = false
            startBButton.backgroundColor = UIColor.redColor()
            
        }
    }
    
    @IBAction func startCpushed(sender: AnyObject) {
        if !self.isRecording {
            // start recording
            startRecording("videoC.mp4")
            startCButton.backgroundColor = UIColor.grayColor()
        } else {
            fileOutput.stopRecording()
            
            self.isRecording = false
            startCButton.backgroundColor = UIColor.redColor()
            
        }
    }
    
    func onClickStartButton(sender: UIButton){
        if !self.isRecording {
            // start recording
            startRecording("videoA.mp4")
            self.changeButtonColor(self.startButtonA, color: UIColor.grayColor())
            self.changeButtonColor(self.stopButtonA, color: UIColor.redColor())
        }
    }
    
    func onClickStopButton(sender: UIButton){
        if self.isRecording {
            fileOutput.stopRecording()
            
            self.isRecording = false
            self.changeButtonColor(self.startButtonA, color: UIColor.redColor())
            self.changeButtonColor(self.stopButtonA, color: UIColor.grayColor())
        }
    }

    func startRecording(filename: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let filePath : String? = "\(documentsDirectory)/\(filename)"
        let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
        fileOutput.startRecordingToOutputFileURL(fileURL, recordingDelegate: self)
        
        self.isRecording = true
    }
    
    func changeButtonColor(target: UIButton, color: UIColor){
        target.backgroundColor = color
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let assetsLib = ALAssetsLibrary()
        assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
    }
}