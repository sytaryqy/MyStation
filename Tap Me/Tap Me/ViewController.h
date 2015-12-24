//
//  ViewController.h
//  Tap Me
//
//  Created by sytar on 15/12/21.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    
    //add another three variables
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
    AVAudioPlayer *backgroundSound;
    AVAudioPlayer *timeSound;
    AVAudioPlayer *pressSound;
}

-(IBAction)buttonPressed;

@end

