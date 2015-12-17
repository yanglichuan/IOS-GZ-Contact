//
//  Contact.h
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>


@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *tel;
@end
