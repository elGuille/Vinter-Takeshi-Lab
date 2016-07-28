//
//  PreviewViewController.swift
//  Vinter-Takeshi
//
//  Created by FUJIKI TAKESHI on 2016/05/16.
//  Copyright © 2016年 Guillermo Garcia. All rights reserved.
//

import UIKit
import MediaPlayer

class PreviewViewController: UIViewController {

    @IBOutlet weak var playbackView: UIView!
    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let filePath : String? = "\(documentsDirectory)/videoA.mp4"
        let url : NSURL = NSURL(fileURLWithPath: filePath!)
        
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.playbackView.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = true
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerPlaybackDidFinishNotificationReceived:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerLoadStateDidChangeNotificationReceived:", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillEnterFullscreenNotificationReceived:", name: MPMoviePlayerWillEnterFullscreenNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillExitFullscreenNotificationReceived:", name: MPMoviePlayerWillExitFullscreenNotification, object: nil)
    }
    
    func onMPMoviePlayerPlaybackDidFinishNotificationReceived(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo!
        let reason = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        print("onMPMoviePlayerPlaybackDidFinishNotificationReceived = " + String(reason))
    }
    
    func onMPMoviePlayerLoadStateDidChangeNotificationReceived(notification: NSNotification){
        let state = self.moviePlayer.loadState
        print("onMPMoviePlayerLoadStateDidChangeNotificationReceived = " + String(state.rawValue))
    }
    
    func onMPMoviePlayerWillEnterFullscreenNotificationReceived(notification: NSNotification){
        print("onMPMoviePlayerWillEnterFullscreenNotificationReceived")
    }
    
    func onMPMoviePlayerWillExitFullscreenNotificationReceived(notification: NSNotification){
        print("onMPMoviePlayerWillExitFullscreenNotificationReceived")
    }

    @IBAction func playBvideo(sender: AnyObject) {
        moviePlayer.stop()
        moviePlayer.view.removeFromSuperview()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let filePath : String? = "\(documentsDirectory)/videoB.mp4"
        let url : NSURL = NSURL(fileURLWithPath: filePath!)
        
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.playbackView.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = false
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
    }
    
    @IBAction func playCvideo(sender: AnyObject) {
        moviePlayer.stop()
        moviePlayer.view.removeFromSuperview()

        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let filePath : String? = "\(documentsDirectory)/videoC.mp4"
        let url : NSURL = NSURL(fileURLWithPath: filePath!)
        
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.playbackView.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = false
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
    }
    
}
