//
//  ViewController.m
//  A05.plist文件存储
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
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSLog(@"%@",doc);
    NSString *plistPath = [doc stringByAppendingPathComponent:@"data.plist"];
    
    //读取
    
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    NSLog(@"%@",array);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //把数据保存到沙盒的一个plist文件里
    
    NSArray *data = @[@"asd",@"asds"];
    
    // 获取document目录
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSLog(@"%@",doc);
    NSString *plistPath = [doc stringByAppendingPathComponent:@"data.plist"];
//
    //把数据写入一个文件
    [data writeToFile:plistPath atomically:YES];
}

@end
