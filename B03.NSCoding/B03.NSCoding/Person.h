//
//  Person.h
//  B03.NSCoding
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int age;

@end
