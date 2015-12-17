//
//  ViewController.m
//  A05.plist文件存储
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"

@interface ViewController ()

@property (nonatomic,copy) NSString *plistPath;

@end

@implementation ViewController

-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSLog(@"%@",doc);
        _plistPath = [doc stringByAppendingPathComponent:@"data.plist"];
    }
    
    return _plistPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    //查看沙盒的路径
    //1.控制台打印沙盒的路径,使用finder-前往-文件夹 打开
    //2.控制台打印沙盒的路径,打开终端 open + 路径
    //3.使用simpholders工具
    //4.可以断点 输入po NSHomeDirectory()
    
    //获取缓存路径(cache)
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachePath);
    
    
    //获取临时路径(tmp)
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"%@",tmpPath);
    
    //主目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [self testString];

    //不是所有对象都有可使用write方法
    Contact *contact = [[Contact alloc] init];
    contact.name = @"zhangsan";
    

}

-(void)testString{
    NSString *data = @"aabc";
    
    //写字符串
    [data writeToFile:self.plistPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //读字符串
    NSString *str = [NSString stringWithContentsOfFile:self.plistPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",str);
    
    
}

-(void)testDictionary{
    //把数据保存到沙盒的一个plist文件里
    NSDictionary *data = @{@"name":@"zhangsan",@"age":@23};
    
    //把数据写入一个文件
    [data writeToFile:self.plistPath atomically:YES];
    
    
    //读取
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
    NSLog(@"%@",dict);

}


/**
 *  测试数组存储在一个plist文件
 */
-(void)testArray{
    //把数据保存到沙盒的一个plist文件里
    NSArray *data = @[@"asd",@"asds"];
    
    //把数据写入一个文件
    [data writeToFile:self.plistPath atomically:YES];
    
    
    //读取
    NSArray *array = [NSArray arrayWithContentsOfFile:self.plistPath];
    NSLog(@"%@",array);
}
@end
