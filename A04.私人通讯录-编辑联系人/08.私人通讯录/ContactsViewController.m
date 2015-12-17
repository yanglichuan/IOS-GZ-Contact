//
//  ContactsViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddContactViewController.h"
#import "EditContactViewController.h"
#import "Contact.h"

@interface ContactsViewController ()<AddContactViewControllerDelegate,EditContactViewControllerDelegate>

@property (nonatomic,strong)NSMutableArray   *contacts;

@end

@implementation ContactsViewController


-(NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup
    //设置标题
    self.title = [NSString stringWithFormat:@"%@的联系人",self.name];

}



#pragma mark 表格的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%s",__func__);
    static NSString *ID = @"ContactCell";
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];

    
    //显示数据
    Contact *contact = self.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.tel;
    
    return cell;
}


- (IBAction)logoutBtnClick:(id)sender {
    //注销
    //直接返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //获取目录控制器
    id destVc = segue.destinationViewController;
    
    //判断类型
    if ([destVc isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addContactVc = destVc;
        addContactVc.delegate = self;
    }else if([destVc isKindOfClass:[EditContactViewController class]]){
        //1.获取目标控制器
        EditContactViewController *editVc = destVc;
        
        //2.获取对应索引的联系人
        NSInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
        Contact *contact = self.contacts[selectedRow];
        
        //3.设置编辑联系人控制器的contact属性
        editVc.contact = contact;
        
        //4.设置编辑联系人的代理
        editVc.delegate = self;
    }
    
}


//-(void)addContactViewController:(AddContactViewController *)addContactVc didSaveContactWithName:(NSString *)name tel:(NSString *)tel{
//   
//    Contact *contact = [[Contact alloc] init];
//    contact.name = name;
//    contact.tel = tel;
//    
//    //添加联系人数组
//    [self.contacts addObject:contact];
//
//    //刷新表格
//    [self.tableView reloadData];
//    
//    
//    //隐藏添加联系人的控制器
//    [self.navigationController popViewControllerAnimated:YES];
//}


#pragma mark 添加联系人控制器的代理
-(void)addContactViewController:(AddContactViewController *)addContactVc didSaveContact:(Contact *)contact{
    // 1.把模型添加到联系人数组
    [self.contacts addObject:contact];
    
    //刷新
    //[self.tableView reloadData];
    
    // 2.刷新局部刷新
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.contacts.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
    // 3.隐藏添加联系人的控制器
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 编辑联系人控制器的代理

-(void)editContactViewController:(EditContactViewController *)editContactVc didFinishedSaveContact:(Contact *)contact{
    // 隐藏编辑联系人的控制器
    [self.navigationController popViewControllerAnimated:YES];

    // 局部刷新
    
    //获取当前刷新的行
    NSInteger row = [self.contacts indexOfObject:contact];
    NSIndexPath *refreshIndex = [NSIndexPath indexPathForRow:row inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[refreshIndex] withRowAnimation:UITableViewRowAnimationFade];
    
   
}

@end
