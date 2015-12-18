//
//  Person.h
//  PeopleDatabase
//
//  Created by sytar on 15/12/18.
//  Copyright © 2015年 sytar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString *firstName;
    NSString *lastName;
    int age;
}

- (void) enterInfo;
- (void) printInfo;
@end
