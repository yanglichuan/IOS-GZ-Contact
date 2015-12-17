//
//  LoginViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactsViewController.h"
#import "MBProgressHUD+CZ.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginBtnClick;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)loginBtnClick {
    
    //判断用户名密码是否正确定，只有正确的情况下，才能进行下一个界面
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    
    //不添加toView参数，提示框是添加在window上
    [MBProgressHUD showMessage:@"正在登录中。。。"];
   
    //toView代表提示框添加到哪个view上
    //[MBProgressHUD showMessage:@"正在登录中。。。" toView:self.view];
    //[MBProgressHUD showMessage:@"正在登录中。。。" toView:self.navigationController.view];
    
    
    //模拟登录有一个等待过程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //登录完成 隐藏提示框
        [MBProgressHUD hideHUD];
        //[MBProgressHUD hideHUDForView:self.view];
        
        if ([account isEqualToString:@"zhangsan"] && [password isEqualToString:@"123"]) {//帐号与密码正确
            NSLog(@"帐号与密码正确");
            
            //执行一个segue，就会进入segue所指的控制器
            [self performSegueWithIdentifier:@"toContactsSegue" sender:nil];
        }else{
            NSLog(@"帐号或者密码不正确");
            
            //给一个错误的提示
            [MBProgressHUD showError:@"帐号或者密码不正确"];
        }
    });
    
    
    
}

/**
 *  使用segue跳转下一个界面之前会调用
 *
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%s",__func__);
    

    NSLog(@"源控制器 %@",segue.sourceViewController);
    NSLog(@"目标控制器 %@",segue.destinationViewController);
    //可以传递数据给下一个控制器
    //目录控制器
    id destVc = segue.destinationViewController;
    
    //判断控制器的类型

    if ([destVc isKindOfClass:[ContactsViewController class]]) {
        ContactsViewController *contactsVc = destVc;
        //设置名字属性
        contactsVc.name = self.accountField.text;
    }
}
@end
