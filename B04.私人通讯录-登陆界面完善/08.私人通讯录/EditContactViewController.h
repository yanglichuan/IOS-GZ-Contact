//
//  EditContactViewController.h
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact,EditContactViewController;


@protocol EditContactViewControllerDelegate <NSObject>

-(void)editContactViewController:(EditContactViewController *)editContactVc didFinishedSaveContact:(Contact *)contact;

@end

@interface EditContactViewController : UIViewController


/**
 *  联系人
 */
@property (nonatomic,strong)Contact   *contact;


@property (weak, nonatomic) id<EditContactViewControllerDelegate> delegate;

@end
