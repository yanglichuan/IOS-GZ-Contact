//
//  AddContactViewController.h
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddContactViewController,Contact;

@protocol AddContactViewControllerDelegate <NSObject>

@optional
-(void)addContactViewController:(AddContactViewController *)addContactVc didSaveContactWithName:(NSString *)name tel:(NSString *)tel;

/**
 *  直接返回一个联系人模型
 */
-(void)addContactViewController:(AddContactViewController *)addContactVc didSaveContact:(Contact *)contact;


@end

@interface AddContactViewController : UIViewController

@property (weak, nonatomic)  id<AddContactViewControllerDelegate> delegate;

@end
