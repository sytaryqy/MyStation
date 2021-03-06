//
//  ViewController.m
//  Tap Me
//
//  Created by sytar on 15/12/21.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *) type{
    NSString *path=[[NSBundle mainBundle] pathForResource:file ofType:type];
    
    NSURL *url= [NSURL fileURLWithPath:path];
    NSError *error;
    
    AVAudioPlayer *audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if(!audioPlayer){
        NSLog(@"%@",[error debugDescription]);
    }
    
    return audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    backgroundSound=[self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:(@"mp3")];
    timeSound=[self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    pressSound=[self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    [self initalizeGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed{
    //NSLog(@"Pressed!");
    //scoreLabel.text=@"Pressed";
    count++;
    [pressSound play];
    scoreLabel.text=[NSString stringWithFormat:@"SCORE\n%li",(long)count];
}

-(void)initalizeGame{
    //1.initalize the variables
    count=0;
    seconds=30;
    //2.display the value in the lable
    scoreLabel.text=[NSString stringWithFormat:@"SCORE\n%li",(long)count];
    timerLabel.text=[NSString stringWithFormat:@"Time:%li",(long)seconds];
    //3.set the timer
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTimer) userInfo:nil repeats:YES ];
    [backgroundSound setVolume:0.3f];
    [backgroundSound play];
}

-(void)subtractTimer{
    //1.change the seconds and the timerLable's text
    seconds--;
    [timeSound play];
    timerLabel.text=[NSString stringWithFormat:@"Time:%li",(long)seconds];
    
    //2.if seconds equal 0 ,we need invalidate≈ the timer.
    if (seconds==0) {
        [timer invalidate];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:[NSString stringWithFormat: @"Your score is %li",(long)count]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Play Again" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self initalizeGame];}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
        }
    
}

@end
