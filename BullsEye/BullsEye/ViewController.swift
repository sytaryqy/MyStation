//
//  ViewController.swift
//  BullsEye
//
//  Created by sytar on 15/12/25.
//  Copyright © 2015年 sytaryqy. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
//    var currentSliderValue:Int=0
//    var targetValue:Int=0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel:UILabel!
    
    //using type inference
    var currentSliderValue=0
    var targetValue=0
    var score=0
    var rounds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable =
            trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        //currentSliderValue=lroundf(slider.value)
        //targetValue=1+Int(arc4random_uniform(100))
        startNewRound()
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        
//        var difference:Int
//        
//        if currentSliderValue > targetValue{
//            difference = currentSliderValue - targetValue
//        }else if targetValue > currentSliderValue{
//            difference = targetValue - currentSliderValue
//        }else {
//            difference = 0
//        }
        let difference=abs(targetValue - currentSliderValue)
        let points=100-difference
//        let message="Your score:\(points)"
        score += points
        var message = "Your score:\(points)"
        var playerMessage = " "
        if points == 100 {
            playerMessage="Perfect!"
            message = message + "\nYou get another 100 points!"
            score += 100
        }else if points >= 80{
            playerMessage = "You almost had it!"
        }else if points >= 60{
            playerMessage = "Not bad!"
        }else {
            playerMessage = "Not even close!"
        }
//        let message="The value of the slider is: \(currentSliderValue)"+"\nThe target value is: \(targetValue)"+"\nThe difference value is:\(difference)"
        let alert=UIAlertController (title: playerMessage, message: message, preferredStyle: .Alert)
        let action=UIAlertAction (title: "OK", style: .Default, handler: {
            action in self.startNewRound()
            self.updateLabel()
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
//        startNewRound()
//        updateLabel()
    }
    
    @IBAction func sliderMoved(slider:UISlider){
        //print("The value of the slider is now: \(slider.value)")
        currentSliderValue=lroundf(slider.value)
    }
    
    func startNewRound(){
        targetValue=1+Int(arc4random_uniform(100))
        currentSliderValue=50;
        slider.value=Float(currentSliderValue)
        rounds += 1
    }
    
    func updateLabel(){
        targetLabel.text=String(targetValue)
        scoreLabel.text=String(score)
        roundLabel.text=String(rounds)
    }
    
    @IBAction func restartGame(){
        let message = "Are you sure you want restart the game?"
        let alert=UIAlertController (title: "RestartGame", message: message, preferredStyle: .Alert)
        let actionYes=UIAlertAction (title: "Yes", style: .Default, handler: {
            action in self.resetGameDatas()
        })
        let actionCancel=UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionCancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func resetGameDatas(){
        score = 0
        rounds = 0
        startNewRound()
        updateLabel()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }


}

