//
//  Person.m
//  B03.NSCoding
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //指定 每个属性 怎么存储
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    //读取 数据 设置每个属性
    if(self = [super init]){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
    }
    
    return self;
}

@end
