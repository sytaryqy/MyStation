//
//  main.m
//  PeopleDatabase
//
//  Created by sytar on 15/12/16.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSString *helloWorld=@"Hello, World!";
        NSLog(@"%@",helloWorld);
        
        //use nsstring object show the string.
        int i=10;
        NSString *stringShow=[NSString stringWithFormat:@"The number is %i",i];
        NSLog(@"%@",stringShow);
        
        //scanf can only used in int/char/float/bool
        
        //How to use scanf load the words.
        NSLog(@"Please input a word.");
        char cstring[40];
        scanf("%s",cstring);
        NSString  *stringInput=[NSString stringWithCString:cstring encoding:1];
        NSLog(@"%@",stringInput);
    }
    return 0;
}
