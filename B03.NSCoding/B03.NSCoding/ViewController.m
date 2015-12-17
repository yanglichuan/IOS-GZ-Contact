//
//  ViewController.m
//  B03.NSCoding
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"

/**
 *  NSKeyedArchiver 保存数据
 * NSKeyedUnarchiver 读取数据
 */

@interface ViewController ()
- (IBAction)saveData;
- (IBAction)readData;

@property (nonatomic,copy) NSString *plistPath;

@end

@implementation ViewController

-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSLog(@"%@",doc);
        _plistPath = [doc stringByAppendingPathComponent:@"data.archiver"];
    }
    
    return _plistPath;
}


//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UIButton
    //保存字典
    [self testDict];
    
    //读字典
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
    NSLog(@"%@",dict);
    
}

-(void)readData{
    //读数据
    Contact *contact = [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
    NSLog(@"name:%@ age:%d tel:%@ ",contact.name,contact.age,contact.tel);
}

- (IBAction)saveData {
    
    Contact *contact = [[Contact alloc] init];
    contact.name = @"张三";
    contact.age = 27;
    contact.tel = @"13531232323";
    
    [NSKeyedArchiver archiveRootObject:contact toFile:self.plistPath];
    
}


/**
 *  测试 系统的NSDictionary NSArray的归档
 *  只有 对象 遵守了NSCoding协议才可以使用NSKeyedArchiver进行数据存储
 */
-(void)testDict{
    //使用 “归档” 方法保存数据
    
    //NSArray *data = @[@"asbc",@23];
    NSDictionary *data = @{@"name":@"zhangs",@"heigt":@1.90};
    
    //直接把一个对象保存到沙盒里
    [NSKeyedArchiver archiveRootObject:data toFile:self.plistPath];
}

@end
