//
//  ContactsViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup
    //设置标题
    self.title = [NSString stringWithFormat:@"%@的联系人",self.name];

}

- (IBAction)logoutBtnClick:(id)sender {
    //注销
    //直接返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

@end
