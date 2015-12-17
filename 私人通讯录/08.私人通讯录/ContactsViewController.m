//
//  ContactsViewController.m
//  08.私人通讯录
//
//  Created by Apple on 14/12/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/**
 *  保存联系人 使用NSKeyedArcheiver
 *  1.Cnntact要遵守 NSCoding
 *  2.文件保存的路径
 *  3.NSKeyedArcheiver 保存
 *  4.NSKeyedUnArcheiver 读取数据
 */

#import "ContactsViewController.h"
#import "AddContactViewController.h"
#import "EditContactViewController.h"
#import "Contact.h"

@interface ContactsViewController ()<AddContactViewControllerDelegate,EditContactViewControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)NSMutableArray   *contacts;
/**
 *  联系人数据保存的路径
 */
@property (nonatomic,copy) NSString *contactPath;
@end

@implementation ContactsViewController

-(NSString *)contactPath{
    if (!_contactPath) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _contactPath = [doc stringByAppendingPathComponent:@"contacts.archiver"];
    }
    
    return _contactPath;
}

-(NSMutableArray *)contacts{
    if (!_contacts) {
        //先从 "沙盒" 获取数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:self.contactPath];
        
        //程序第一次使用，沙盒没有联系人数据
        if(!_contacts){
            _contacts = [NSMutableArray array];
        }
    }
    
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup
    //设置标题
    self.title = [NSString stringWithFormat:@"%@的联系人",self.name];
    NSLog(@"%@",self.contactPath);
    ///Users/apple/Library/Developer/CoreSimulator/Devices/0AF359D0-F8A2-4927-A8D1-643C209CBFF0/data/Containers/Data/Application/78A25E97-EAE5-44B5-B743-0D50F2D5CCEA/Documents/contacts.archiver
    //~/Documents/contacts.archiver
    
    //在导航栏右边加个按钮
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItems = @[deleteItem,self.navigationItem.rightBarButtonItem];
    
}

-(void)delete{
    // 设置设置表格的 ”编辑“ 属性
    //self.tableView.editing = YES;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

#pragma mark 返回表格的 "编辑" 状态
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    
    if(editingStyle == UITableViewCellEditingStyleDelete){//删除
        
        //删除联系人
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        //刷新表格
        NSIndexPath *deleteIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[deleteIndex] withRowAnimation:UITableViewRowAnimationFade];
        
        //同步数据
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
    
    }else if(editingStyle == UITableViewCellEditingStyleInsert){//添加按钮
        //添加一个10086联系人
        Contact *contact = [[Contact alloc] init];
        contact.name = @"中国移动";
        contact.tel = @"10086";
        
        //保存数据，刷新表格
        [self.contacts insertObject:contact atIndex:indexPath.row + 1];
        
        NSIndexPath *insertIndex = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[insertIndex] withRowAnimation:UITableViewRowAnimationFade];
        
        //同步数据
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
    
    }
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
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提醒" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    //直接返回上一个控制器
    //[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIActionSheet的代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }

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
    
    // 4.同步新数据到 沙盒
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
    
    
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
    
    
    // 同步新数据到 沙盒
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
   
}

@end
