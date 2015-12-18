//
//  Person.m
//  PeopleDatabase
//
//  Created by sytar on 15/12/18.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)enterInfo{
    NSLog(@"What is the first name?");
    char cstring[40];
    scanf("%s",cstring);
    firstName=[NSString stringWithCString:cstring encoding :1];
    
    NSLog(@"What is %@'s last name",firstName);
    scanf("%s",cstring);
    lastName=[NSString stringWithCString:cstring encoding:1];
    
    NSLog(@"How old is %@ %@?",firstName,lastName);
    scanf("%i",&age);
}

-(void)printInfo{
    NSLog(@"First name:%@",firstName);
    NSLog(@"%@ %@ is %i years old.",firstName,lastName,age);
}
@end
