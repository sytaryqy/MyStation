//
//  ViewController.swift
//  BullsEye
//
//  Created by sytar on 15/12/25.
//  Copyright © 2015年 sytaryqy. All rights reserved.
//

import UIKit

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
    var rounds = -1

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let action=UIAlertAction (title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        updateLabel()
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


}

