//
//  AddContactViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "AddContactViewController.h"
#import "Contact.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveBtnClick {
    // 1.获取姓名和电话
//    NSString *name = self.nameField.text;
//    NSString *tel = self.telField.text;
    
    // 2.通知上一个控制器，完成联系人保存
//    if ([self.delegate respondsToSelector:@selector(addContactViewController:didSaveContactWithName:tel:)]) {
//        [self.delegate addContactViewController:self didSaveContactWithName:name tel:tel];
//    }
    
    if ([self.delegate respondsToSelector:@selector(addContactViewController:didSaveContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameField.text;
        contact.tel = self.telField.text;
        
        [self.delegate addContactViewController:self didSaveContact:contact];
    }
    
    // 3.上一个控制器刷新表格

}



@end
