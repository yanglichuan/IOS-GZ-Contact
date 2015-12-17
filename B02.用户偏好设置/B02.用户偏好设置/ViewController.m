
//
//  ViewController.m
//  B02.用户偏好设置
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    [self modify];

}

-(void)modify{
    //修改 用户偏好设置 数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"321" forKey:@"password"];
    [defaults synchronize];
}

-(void)delete{
    //删除 用户偏好设置 数据
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    [defautls removeObjectForKey:@"account"];
    
    //删除记得也要调用 同步的方法
    [defautls synchronize];
    
}

-(void)read{
    //读取 用户偏好设置 的数据
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *account = [defautls objectForKey:@"account"];
    NSString *password = [defautls objectForKey:@"password"];
    BOOL rememberPwd = [defautls boolForKey:@"rememberPwd"];
    BOOL autoLogin = [defautls boolForKey:@"autoLogin"];
    NSLog(@"%@ %@ %d %d",account,password,rememberPwd,autoLogin);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //使用偏好设置保存数据
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存的数据
    [defaults setObject:@"zhangsan" forKey:@"account"];
    [defaults setObject:@"123" forKey:@"password"];
    [defaults setBool:YES forKey:@"autoLogin"];
    [defaults setBool:YES forKey:@"rememberPwd"];
    
    //调用同步的方法，把数据保存到沙盒文件
    [defaults synchronize];
}

@end
