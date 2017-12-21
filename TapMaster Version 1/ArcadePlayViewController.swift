//
//  ArcadePlayViewController.swift
//  TapMaster Version 1
//
//  Created by Brian Lim on 7/24/15.
//  Copyright (c) 2015 LimTech. All rights reserved.
//

import UIKit
import AVFoundation
import iAd
import Social
import GoogleMobileAds
import GameKit

class ArcadePlayViewController: UIViewController, ADBannerViewDelegate, GKGameCenterControllerDelegate {
    
    var interstitial: GADInterstitial!
    
    var tappableItemsArray:[String] = ["RedSquareOne2", "GreenSquareOne", "BlueSquareOne", "PurpleSquareOne", "OrangeSquareOne", "StarOne2"]
    
    var timer:NSTimer!
    var countDownTimer:NSTimer!
    var backgroundColorTimer:NSTimer!
    var textColorTimer:NSTimer!

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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var gameoverPopoverView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    
    var counter:Int = 0
    var star:Int = 2
    var blueSquare:Int = 5
    var greenSquare:Int = 3
    var purpleSquare:Int = 2
    var orangeSquare:Int = 1
    var redSquare:Int = 5
    var countDown:Int = 30
    var score:Int!
    
    var regularScoreSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("RegularScoreSoundShorter", ofType: "wav")!)
    var addTimeSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("StarSoundShorter", ofType: "wav")!)
    var minusTwoSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("MinusTwoSoundShorter", ofType: "wav")!)
    var fivePointSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CorrectSoundShorter", ofType: "wav")!)
    
    var regularScoreSoundPlayer = AVAudioPlayer()
    var addTimeSoundPlayer = AVAudioPlayer()
    var minusTwoSoundPlayer = AVAudioPlayer()
    var fivePointSoundPlayer = AVAudioPlayer()
    
    var error:NSError?
    var muted: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interstitial = self.createAndLoadAd()
        
        self.canDisplayBannerAds = true
        self.bannerView?.delegate = self
        self.bannerView?.hidden = true
        
        do {
            // Do any additional setup after loading the view.
        
            regularScoreSoundPlayer = try AVAudioPlayer(contentsOfURL: regularScoreSound)
        } catch var error1 as NSError {
            error = error1
            regularScoreSoundPlayer = nil
        }
        do {
            addTimeSoundPlayer = try AVAudioPlayer(contentsOfURL: addTimeSound)
        } catch var error1 as NSError {
            error = error1
            addTimeSoundPlayer = nil
        }
        do {
            minusTwoSoundPlayer = try AVAudioPlayer(contentsOfURL: minusTwoSound)
        } catch var error1 as NSError {
            error = error1
            minusTwoSoundPlayer = nil
        }
        do {
            fivePointSoundPlayer = try AVAudioPlayer(contentsOfURL: fivePointSound)
        } catch var error1 as NSError {
            error = error1
            fivePointSoundPlayer = nil
        }
        
        backgroundImage.alpha = 0
        gameoverPopoverView.alpha = 0
        countDownLabel.text = "\(countDown)"

        timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("handleTimer"), userInfo: nil, repeats: true)
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        backgroundColorTimer = NSTimer.scheduledTimerWithTimeInterval(1.8, target: self, selector: Selector("updateColor"), userInfo: nil, repeats: true)
        
        var tapGestureOne: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureOne:"))
        var tapGestureTwo: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureTwo:"))
        var tapGestureThree: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureThree:"))
        var tapGestureFour: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureFour:"))
        var tapGestureFive: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureFive:"))
        var tapGestureSix: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureSix:"))
        var tapGestureSeven: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureSeven:"))
        var tapGestureEight: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureEight:"))
        var tapGestureNine: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGestureNine:"))
        
        topLeftImageView.addGestureRecognizer(tapGestureOne)
        topMiddleImageView.addGestureRecognizer(tapGestureTwo)
        topRightImageView.addGestureRecognizer(tapGestureThree)
        middleLeftImageView.addGestureRecognizer(tapGestureFour)
        middleImageView.addGestureRecognizer(tapGestureFive)
        middleRightImageView.addGestureRecognizer(tapGestureSix)
        bottomLeftImageView.addGestureRecognizer(tapGestureSeven)
        bottomMiddleImageView.addGestureRecognizer(tapGestureEight)
        bottomRightImageView.addGestureRecognizer(tapGestureNine)
        
        topLeftImageView.userInteractionEnabled = true
        topMiddleImageView.userInteractionEnabled = true
        topRightImageView.userInteractionEnabled = true
        middleLeftImageView.userInteractionEnabled = true
        middleImageView.userInteractionEnabled = true
        middleRightImageView.userInteractionEnabled = true
        bottomLeftImageView.userInteractionEnabled = true
        bottomMiddleImageView.userInteractionEnabled = true
        bottomRightImageView.userInteractionEnabled = true
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
    
    //send high score to leaderboard
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "ColorTappLeaderboard_26") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil {
                    print("error")
                }
            })
            
        }
        
    }
    
    //shows leaderboard screen
    func showLeader() {
        
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "ColorTappLeaderboard_26"
        self.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func leaderboardBtnPressed(sender: AnyObject) {
        
        showLeader()
    }

    
    @IBAction func twitterButtonPressed(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I just got a score of \(score) in Arcade Mode on #ColorTapp ! Can you beat mine?")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func rateButtonPressed(sender: AnyObject) {
        
        // Redirect the user to the app store
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(1037661414)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1)")!)
        
    }
    
    func handleTimer() {
        
        let randomizedNumber1 = Int((arc4random_uniform(6)))
        let randomizedNumber2 = Int((arc4random_uniform(6)))
        let randomizedNumber3 = Int((arc4random_uniform(6)))
        let randomizedNumber4 = Int((arc4random_uniform(6)))
        let randomizedNumber5 = Int((arc4random_uniform(6)))
        let randomizedNumber6 = Int((arc4random_uniform(6)))
        let randomizedNumber7 = Int((arc4random_uniform(6)))
        let randomizedNumber8 = Int((arc4random_uniform(6)))
        let randomizedNumber9 = Int((arc4random_uniform(6)))
        
        
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
    
    func updateTimer() {
     
        countDown--
        countDownLabel.text = "\(countDown)"
        
        if countDownLabel.text == "0" || countDown == 0 || countDown < 0 {
            
            countDownLabel.text = ""
            countDownTimer.invalidate()
            backgroundColorTimer.invalidate()
            timer.invalidate()
            score = Int(scoreLabel.text?)
            
            topLeftImageView.userInteractionEnabled = false
            topMiddleImageView.userInteractionEnabled = false
            topRightImageView.userInteractionEnabled = false
            middleLeftImageView.userInteractionEnabled = false
            middleImageView.userInteractionEnabled = false
            middleRightImageView.userInteractionEnabled = false
            bottomLeftImageView.userInteractionEnabled = false
            bottomMiddleImageView.userInteractionEnabled = false
            bottomRightImageView.userInteractionEnabled = false
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                self.topMiddleImageView.image = nil
                self.middleImageView.image = nil
                
                self.gameoverPopoverView.alpha = 1
                self.yourScoreLabel.text = "\(self.score)"
                
                let highscoreDefault = NSUserDefaults.standardUserDefaults()
                
                // Checking to see if there is a value in the key "highscore"
                if let highscore = highscoreDefault.stringForKey("highscoreSecondView") {
                    
                    self.highscoreLabel.text = "\(highscore)"
                    
                    // If there isnt a value for that key, then set a new value for that key
                    // Set the highscore label text to the current score
                } else {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscoreSecondView")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    self.checkAd()
                    self.saveHighscore(self.score)
                    
                }
                
                // Checking to see if the current score is greater than the highscore, if so
                // Set the current score as the new highscore
                if self.score > highscoreDefault.valueForKey("highscoreSecondView") as! Int {
                    
                    highscoreDefault.setValue(self.score, forKey: "highscoreSecondView")
                    self.highscoreLabel.text = "\(self.score)"
                    self.animateText()
                    self.saveHighscore(self.score)
                }
                
                if self.gameoverPopoverView.alpha == 1 {
                
                    if self.score > 50 && self.score < 60 {
                        
                        self.checkAd()
                        
                    } else if self.score > 90 && self.score < 100 {
                        
                        self.checkAd()
                        
                    } else if self.score > 150 && self.score < 170 {
                        
                        self.checkAd()
                        
                    } else if self.score > 200 && self.score < 220 {
                        
                        self.checkAd()
                        
                    } else if self.score > 300 && self.score < 320 {
                        
                        self.checkAd()
                        
                    } else if self.score > 400 && self.score < 410 {
                        
                        self.checkAd()
                        
                    } else if self.score > 420 {
                        
                        self.checkAd()
                    }
                    
                }
                
            })
            
        }

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

    
    func handleTapGestureOne(tapGesture: UITapGestureRecognizer) {
        
        
        if topLeftImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            topLeftImageView.image = nil
            
        } else if topLeftImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
            }
            
            topLeftImageView.image = nil
        }
        
        
    }
    
    func handleTapGestureTwo(tapGesture: UITapGestureRecognizer) {
        
        
        if topMiddleImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            topMiddleImageView.image = nil
            
        } else if topMiddleImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            
            topMiddleImageView.image = nil
        }
    }
    
    func handleTapGestureThree(tapGesture: UITapGestureRecognizer) {
        
        
        if topRightImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            topRightImageView.image = nil
            
        } else if topRightImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            topRightImageView.image = nil
        }
        
        
    }
    
    func handleTapGestureFour(tapGesture: UITapGestureRecognizer) {
        
        
        if middleLeftImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            middleLeftImageView.image = nil
            
        } else if middleLeftImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            middleLeftImageView.image = nil
        }
    }
    
    func handleTapGestureFive(tapGesture: UITapGestureRecognizer) {
        
        
        if middleImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            middleImageView.image = nil
            
        } else if middleImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            middleImageView.image = nil
        }
        
    }
    
    func handleTapGestureSix(tapGesture: UITapGestureRecognizer) {
        
        
        if middleRightImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            middleRightImageView.image = nil
            
        } else if middleRightImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            middleRightImageView.image = nil
        }
    }
    
    func handleTapGestureSeven(tapGesture: UITapGestureRecognizer) {
        
        
        
        if bottomLeftImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            bottomLeftImageView.image = nil
            
        } else if bottomLeftImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            bottomLeftImageView.image = nil
        }
    }
    
    func handleTapGestureEight(tapGesture: UITapGestureRecognizer) {
        
        
        if bottomMiddleImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            bottomMiddleImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            bottomMiddleImageView.image = nil
        }
    }
    
    func handleTapGestureNine(tapGesture: UITapGestureRecognizer) {
        
        
        if bottomRightImageView.image == UIImage(named: "GreenSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + greenSquare
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "BlueSquareOne") {
            
            fivePointSoundPlayer.play()
            counter = counter + blueSquare
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "PurpleSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + purpleSquare
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "OrangeSquareOne") {
            
            regularScoreSoundPlayer.play()
            counter = counter + orangeSquare
            scoreLabel.text = "\(counter)"
            bottomRightImageView.image = nil
            
        } else if bottomRightImageView.image == UIImage(named: "StarOne2") {
            
            if countDown != 0 {
                
                addTimeSoundPlayer.play()
                countDown = countDown + star
                countDownLabel.text = "\(countDown)"
                
            }
            
            bottomRightImageView.image = nil
            
        } else if bottomMiddleImageView.image == UIImage(named: "RedSquareOne2") {
            
            if countDown > 2 {
                
                minusTwoSoundPlayer.play()
                countDown = countDown - redSquare
                countDownLabel.text = "\(countDown)"
                
            }
            
            bottomMiddleImageView.image = nil
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
