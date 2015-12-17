//
//  Contact.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "Contact.h"

@implementation Contact


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        //一定要赋值
        self.name =  [aDecoder decodeObjectForKey:@"name"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
    }
    
    return self;
}
@end
