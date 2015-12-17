//
//  Contact.m
//  B03.NSCoding
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    
    //添加自己属性的存储
    [aCoder encodeObject:self.tel forKey:@"tel"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    //子类实现initWithCoder方法时， self 不要写 self = [super init]
    if (self = [super initWithCoder:aDecoder]) {
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
    }
    
    return self;
}

@end
