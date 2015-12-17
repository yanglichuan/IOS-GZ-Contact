//
//  EditContactViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"

@interface EditContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置文本框默值
    self.nameField.text = self.contact.name;
    self.telField.text = self.contact.tel;
}


- (IBAction)editBtnClick:(UIBarButtonItem *)item {


    
    // 1.如果当前是不可用状态 设置文本输入框为可用，按钮可见
    
//    if(self.nameField.enabled){
//        self.nameField.enabled = NO;
//    }
    
    self.nameField.enabled = !self.nameField.enabled;
    self.telField.enabled = !self.telField.enabled;
    self.saveBtn.hidden = !    self.saveBtn.hidden;
    
    // 2.改变 "编辑" 按钮的文字
    if (self.nameField.enabled) {
        item.title = @"取消";
    }else{
        item.title = @"编辑";
    }
    
    
 
}

- (IBAction)saveBtnClick:(id)sender {
    
    // 3.通过代理通知上一个控制器 "完成" 联系人编辑
    if ([self.delegate respondsToSelector:@selector(editContactViewController:didFinishedSaveContact:)]) {
        // 更改联系人模型
        self.contact.name = self.nameField.text;
        self.contact.tel = self.telField.text;
        
        // 调用代理
        [self.delegate editContactViewController:self didFinishedSaveContact:self.contact];
    }
    
}


@end
