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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed{
    //NSLog(@"Pressed!");
    //scoreLabel.text=@"Pressed";
    count++;
    scoreLabel.text=[NSString stringWithFormat:@"SCORE\n%i",count];
}

-(void)initalizeGame{
    //1.initalize the variables
    count=0;
    seconds=30;
    //2.display the value in the lable
    scoreLabel.text=[NSString stringWithFormat:@"SCORE\n%i",count];
    timerLabel.text=[NSString stringWithFormat:@"Time:%i",seconds];
    //3.set the timer
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(subtract) userInfo:nil repeats:YES<#(BOOL)#> ];
}

@end
