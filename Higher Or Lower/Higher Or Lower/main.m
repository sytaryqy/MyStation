//
//  main.m
//  Higher Or Lower
//
//  Created by sytar on 15/12/15.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int answer=arc4random() % 100 +1;
        int guess=0;
        int turn=0;
        //NSLog(@"answer=%i;guess=%i;turn=%i",answer,guess,turn);
        //NSLog(@"Please input a number between 1 and 100.");
        //scanf("%i",&guess);
        //NSLog(@"You enter the number %i",guess);
        while (guess!=answer) {
            if (guess>answer) {
                NSLog(@"The guess is too high!");
            }
            if (guess<answer) {
                NSLog(@"The guess is too lower!");
            }
            turn++;
            NSLog(@"The turn is %i.Please input a number between 1 and 100 again.",turn);
            scanf("%i",&guess);
        }
        if (guess==answer) {
            NSLog(@"You are right! The answer is %i.It took you %i tries.",answer,turn);
        }
       
    }
    return 0;
}
