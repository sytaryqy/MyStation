//
//  ViewController.swift
//  BullsEye
//
//  Created by sytar on 15/12/25.
//  Copyright © 2015年 sytaryqy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentSliderValue:Int=0;
    @IBOutlet weak var slider: UISlider!
    var targetValue:Int=0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //currentSliderValue=lroundf(slider.value)
        //targetValue=1+Int(arc4random_uniform(100))
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        let message="The value of the slider is: \(currentSliderValue)"+"\nThe target value is: \(targetValue)"
        let alert=UIAlertController (title: "Hello,world!", message: message, preferredStyle: .Alert)
        let action=UIAlertAction (title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
    }
    
    @IBAction func sliderMoved(slider:UISlider){
        //print("The value of the slider is now: \(slider.value)")
        currentSliderValue=lroundf(slider.value)
    }
    
    func startNewRound(){
        targetValue=1+Int(arc4random_uniform(100))
        currentSliderValue=50;
        slider.value=Float(currentSliderValue)
    }


}

