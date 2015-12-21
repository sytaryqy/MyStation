//
//  main.m
//  PeopleDatabase
//
//  Created by sytar on 15/12/16.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        //NSString *helloWorld=@"Hello, World!";
        //NSLog(@"%@",helloWorld);
        
        //use nsstring object show the string.
        //int i=10;
        //NSString *stringShow=[NSString stringWithFormat:@"The number is %i",i];
        //NSLog(@"%@",stringShow);
        
        //scanf can only used in int/char/float/bool
        
        //How to use scanf load the words.
        //NSLog(@"Please input a word.");
        //char cstring[40];
        //scanf("%s",cstring);
        //NSString  *stringInput=[NSString stringWithCString:cstring encoding:1];
        //NSLog(@"%@",stringInput);
        
        //Using NSString class show the cstring's length
        //NSLog(@"Please input a word.");
        //char cstringl[40];
        //scanf("%s",cstringl);
        ////NSString  *stringShwoLength =[NSString stringWithCString:cstringl encoding:1];
        //NSLog(@"The word you inputed is %@.The length of the word is %li",stringShwoLength,[stringShwoLength length]);
        
        //test object
        //Person *newPerson=[[Person alloc] init];
        //[newPerson enterInfo];
        //[newPerson printInfo];
        
        //do-while
        char response;
        NSMutableArray *persons=[[NSMutableArray alloc]init];
        
        do{
            Person *newPerson=[[Person alloc]init];
            [newPerson enterInfo];
            [newPerson printInfo];
            [persons addObject:newPerson];
            
            NSLog(@"Do you want to enter another name?y/n");
            scanf("\n%c",&response);
            
        }while (response=='y');
        
        NSLog(@"Number of persons in database: %li",[persons count]);
        //for (int i=0; i<[persons count]; i++) {
        //    NSLog(@"");
        //}
        
        for (Person *onePerson in persons) {
            [onePerson printInfo];
         }
    }
    return 0;
}
