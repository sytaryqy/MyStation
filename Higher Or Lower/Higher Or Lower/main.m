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
        NSLog(@"answer=%i;guess=%i;turn=%i",answer,guess,turn);
        
    }
    return 0;
}
