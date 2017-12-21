//
//  NormalPlayViewController.swift
//  TapMaster Version 1
//
//  Created by Brian Lim on 7/18/15.
//  Copyright (c) 2015 LimTech. All rights reserved.
///Users/Brian

import UIKit
import AVFoundation
import iAd
import Social
import GoogleMobileAds
import GameKit

class NormalPlayViewController: UIViewController, ADBannerViewDelegate {
    
    var interstitial: GADInterstitial!
    
    var tappableItemsArray:[String] = ["RedSquare", "RedSquareTwo", "RedSquareThree", "GreenSquare", "GreenSquareTwo", "GreenSquareThree", "GreenSquare", "RedSquare"]
    
    var timer:NSTimer!
    var timerUp:NSTimer!
    var backgroundColorTimer:NSTimer!
    var bannerView:ADBannerView?
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topMiddleImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var middleLeftImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var middleRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomMiddleImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    @IBOutlet weak var gameoverPopoverView: UIView!
    @IBOutlet weak var playAgainButtonTapped: UIButton!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var endGameScoreLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var counter = 0
    var star = 2
    var score: Int!
    
    var correctSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CorrectSoundShorter", ofType: "wav")!)
    var wrongSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("WrongSound", ofType: "wav")!)
    
    var audioPlayer1 = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interstitial = createAndLoadAd()
        
        self.canDisplayBannerAds = true
        self.bannerView?.delegate = self
        self.bannerView?.hidden = true
        
        audioPlayer1 = AVAudioPlayer(contentsOfURL: correctSound, fileTypeHint: nil)
        audioPlayer2 = AVAudioPlayer(contentsOfURL: wrongSound, fileTypeHint: nil)
        
        self.gameoverPopoverView.alpha = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("handleTimer"), userInfo: nil, repeats: true)
        backgroundColorTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateColor"), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        
        let tapGestureOne: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureOne:"))
        let tapGestureTwo: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureTwo:"))
        let tapGestureThree: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureThree:"))
        let tapGestureFour: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureFour:"))
        let tapGestureFive: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureFive:"))
        let tapGestureSix: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureSix:"))
        let tapGestureSeven: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureSeven:"))
        let tapGestureEight: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureEight:"))
        let tapGestureNine: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureNine:"))

        topLeftImageView.addGestureRecognizer(tapGestureOne)
        topMiddleImageView.addGestureRecognizer(tapGestureTwo)
        topRightImageView.addGestureRecognizer(tapGestureThree)
        middleLeftImageView.addGestureRecognizer(tapGestureFour)
        middleImageView.addGestureRecognizer(tapGestureFive)
        middleRightImageView.addGestureRecognizer(tapGestureSix)
        bottomLeftImageView.addGestureRecognizer(tapGestureSeven)
        bottomMiddleImageView.addGestureRecognizer(tapGestureEight)
        bottomRightImageView.addGestureRecognizer(tapGestureNine)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
        self.bannerView?.hidden = false
        
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        
        self.bannerView?.hidden = true
        
    }
    
    
    
    func createAndLoadAd() -> GADInterstitial {
        
        let ad = GADInterstitial(adUnitID: "ca-app-pub-6536902852765774/5424305447")
        
        let request = GADRequest()
        
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b"]
        ad.loadRequest(request)
        
        return ad
        
    }
    
    func checkAd() {
        
        if (self.interstitial.isReady) {
            
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
            
        }
        
    }
    
    func handleTimer() {
        
        let randomizedNumber1 = Int((arc4random_uniform(8)))
        let randomizedNumber2 = Int((arc4random_uniform(8)))
        let randomizedNumber3 = Int((arc4random_uniform(8)))
        let randomizedNumber4 = Int((arc4random_uniform(8)))
        let randomizedNumber5 = Int((arc4random_uniform(8)))
        let randomizedNumber6 = Int((arc4random_uniform(8)))
        let randomizedNumber7 = Int((arc4random_uniform(8)))
        let randomizedNumber8 = Int((arc4random_uniform(8)))
        let randomizedNumber9 = Int((arc4random_uniform(8)))
        

        let randomizedImage1 = tappableItemsArray[randomizedNumber1]
        let randomizedImage2 = tappableItemsArray[randomizedNumber2]
        let randomizedImage3 = tappableItemsArray[randomizedNumber3]
        let randomizedImage4 = tappableItemsArray[randomizedNumber4]
        let randomizedImage5 = tappableItemsArray[randomizedNumber5]
        let randomizedImage6 = tappableItemsArray[randomizedNumber6]
        let randomizedImage7 = tappableItemsArray[randomizedNumber7]
        let randomizedImage8 = tappableItemsArray[randomizedNumber8]
        let randomizedImage9 = tappableItemsArray[randomizedNumber9]
        
        
        topLeftImageView.image = UIImage(named: randomizedImage1)
        topMiddleImageView.image = UIImage(named: randomizedImage2)
        topRightImageView.image = UIImage(named: randomizedImage3)
        middleLeftImageView.image = UIImage(named: randomizedImage4)
        middleImageView.image = UIImage(named: randomizedImage5)
        middleRightImageView.image = UIImage(named: randomizedImage6)
        bottomLeftImageView.image = UIImage(named: randomizedImage7)
        bottomMiddleImageView.image = UIImage(named: randomizedImage8)
        bottomRightImageView.image = UIImage(named: randomizedImage9)
    }
    
    @IBAction func playAgainButtonPressed(sender: AnyObject) {
        
        self.gameoverPopoverView.alpha = 0
    }
    
    // Use this animate function to animate the label when the user gets a new highscore
    func animateText() {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            // Insert a label, set its alpha to 1
            self.highscoreLabel.alpha = 1
            
            }, completion: {
                
                (Completed: Bool) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    
                    // Insert a label, set its alpha to 0
                    self.highscoreLabel.alpha = 0
                    
                    }, completion: {
                        
                    (Completed: Bool) -> Void in
                        
                    self.animateText()
                        
                    
            })
        })
        
    }
    
    func updateColor() {
        
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.backgroundView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            
        })
        
        
    }
    
    
    @IBAction func twitterButtonPressed(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I just got a score of \(score) in Normal Mode on #ColorTapp ! Can you beat mine?")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    @IBAction func rateButtonPressed(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(1037661414)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1)")!)
        
    }
    
    func handleTapGestureOne(tapGesture: UITapGestureRecognizer) {
        
        
        if topLeftImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
           
            
        } else if topLeftImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
            
        } else if topLeftImageView.image == UIImage(named: "RedSquare") {
            
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                // If there isnt a value for that key, then set a new value for that key
                // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                // Checking to see if the current score is greater than the highscore, if so
                // Set the current score as the new highscore
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
            })
            
        } else if topLeftImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
            })
            
        } else if topLeftImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
            })
        }
            
    }
    
    func handleTapGestureTwo(tapGesture: UITapGestureRecognizer) {

        
        if topMiddleImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if topMiddleImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 15 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 35 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 65 {
                    
                    self.checkAd()
                }
                
                
            })
            
        } else if topMiddleImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
        }
    }
    
    func handleTapGestureThree(tapGesture: UITapGestureRecognizer) {
        
        
        if topRightImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
            
        } else if topRightImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if topRightImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
        }
        
        
    }
    
    func handleTapGestureFour(tapGesture: UITapGestureRecognizer) {
        
        
        if middleLeftImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
            })
            
        } else if middleLeftImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
            
        } else if middleLeftImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
        }
    }
    
    func handleTapGestureFive(tapGesture: UITapGestureRecognizer) {
        
        
        if middleImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if middleImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
            
        } else if middleImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
        }
        
    }
    
    func handleTapGestureSix(tapGesture: UITapGestureRecognizer) {
        
        
        if middleRightImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
            
        } else if middleRightImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
            })
            
        } else if middleRightImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
            })
        }
    }
    
    func handleTapGestureSeven(tapGesture: UITapGestureRecognizer) {
        
        
        
        if bottomLeftImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if bottomLeftImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if bottomLeftImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
        }
    }
    
    func handleTapGestureEight(tapGesture: UITapGestureRecognizer) {
        
        
        if bottomMiddleImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
            
        } else if bottomMiddleImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
            
        } else if bottomMiddleImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
        }
    }
    
    func handleTapGestureNine(tapGesture: UITapGestureRecognizer) {
        
        
        if bottomRightImageView.image == UIImage(named: "GreenSquare") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "GreenSquareTwo") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "GreenSquareThree") {
            
            audioPlayer1.play()
            counter++
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "RedSquare") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()

                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
            
        } else if bottomRightImageView.image == UIImage(named: "RedSquareTwo") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }
                
                
            })
            
        } else if bottomRightImageView.image == UIImage(named: "RedSquareThree") {
            
            audioPlayer2.play()
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.timer.invalidate()
                self.backgroundColorTimer.invalidate()
                self.gameoverPopoverView.alpha = 1
                self.scoreLabel.textColor = UIColor.whiteColor()
                self.score = self.scoreLabel.text?.toInt()
                self.endGameScoreLabel.text = "\(self.score)"
                self.scoreLabel.text = ""
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscore") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    
                    self.checkAd()
                    
                }
                
                if self.score > highscoreDefault.valueForKey("highscore") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscore")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    

                }
                
                if self.score > 10 && self.score < 20 {
                    
                    self.checkAd()
                    
                } else if self.score > 30 && self.score < 40 {
                    
                    self.checkAd()
                    
                } else if self.score > 60 && self.score < 70 {
                    
                    self.checkAd()
                    
                }

                
                
            })
        }
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}
