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


//定义用户偏好设置的key 防止写错
#define rememberPwdKey @"rememberPwd"//记录密码
#define autoLoginKey @"autoLogin"//自动登录
#define accountKey @"account"//帐号
#define passwordKey @"password"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginBtnClick;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPwdSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置 “开关” 默认值
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.rememberPwdSwitch.on = [defaults boolForKey:rememberPwdKey];
    self.autoLoginSwitch.on = [defaults boolForKey:autoLoginKey];
    
    // 设置 帐号 和 密码 默认值
    self.accountField.text = [defaults objectForKey:accountKey];
    if (self.rememberPwdSwitch.isOn) {
        self.passwordField.text = [defaults objectForKey:passwordKey];
    }
    
    //调用 文本变化 的方法
    [self textChange];
    
    // 如果 "自动登录" 勾选，让自动登录
    if (self.autoLoginSwitch.isOn) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loginBtnClick];
        });
    }
    
}

-(void)dealloc{
    //移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//监听文本输入框变化
-(IBAction)textChange{
    NSLog(@"%s",__func__);
    
    self.loginBtn.enabled = (self.accountField.text.length != 0 && self.passwordField.text.length != 0);
    //没有值，禁用登录按钮
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
            
            //保存用户帐和密码
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:account forKey:accountKey];
            //只有 "记住密码" 为开启的状态，才要保存
            if (self.rememberPwdSwitch.isOn) {
                [defaults setObject:password forKey:passwordKey];
            }
            [defaults synchronize];
            
            
        }else{
            NSLog(@"帐号或者密码不正确");
            
            //给一个错误的提示
            [MBProgressHUD showError:@"帐号或者密码不正确"];
        }
    });
    
    
    
}


/**
 *  记录密码开关的值变化
 */
- (IBAction)rememberPwdSwitchChange {
    
    //如果记住密码 为 关闭状态，并且 自动登录为 开启的状态，此时，自动登录 应改为关闭
    if(self.rememberPwdSwitch.isOn == NO && self.autoLoginSwitch.isOn == YES){
        //self.autoLoginSwitch.on = NO;
        
        //添加动画
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
    
    
    //保存开关数据
    [self saveSwitchToPreference];
}

/**
 *  自动登录开关的值变化
 */
- (IBAction)autoLoginSwitchChange {
    
    //如果 自动登录  为 开启状态 并且 记住密码为 关闭状态，些时，记住密码应改为开启
    if(self.autoLoginSwitch.isOn == YES  && self.rememberPwdSwitch.isOn == NO){
        [self.rememberPwdSwitch setOn:YES animated:YES];
    }
    
    [self saveSwitchToPreference];
}

/**
 *  保存开关数据 到 用户偏好设置
 */
-(void)saveSwitchToPreference{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.rememberPwdSwitch.isOn forKey:rememberPwdKey];
    [defaults setBool:self.autoLoginSwitch.isOn forKey:autoLoginKey];
    [defaults synchronize];
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
