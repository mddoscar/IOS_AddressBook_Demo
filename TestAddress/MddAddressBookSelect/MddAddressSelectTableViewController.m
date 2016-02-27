//
//  MddAddressSelectTableViewController.m
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import "MddAddressSelectTableViewController.h"
#import "ChineseString.h"
//引用实体
#import "MddAddressBean.h"
//服务
#import "ServerForAddressBook.h"
#define kTestMode 1
@interface MddAddressSelectTableViewController ()
{
    NSMutableArray * gAddressBookList;

}
@end

@implementation MddAddressSelectTableViewController
@synthesize indexArray;
@synthesize LetterResultArr;

- (void)viewDidLoad
{

    [super viewDidLoad];
   
    [self myInit];
    
   
}
//获取通讯录内容
-(void) myInit
{
    [self initData];
}
-(void) initData
{    self.title = @"";
    
#if kTestMode
    //这个界面数据
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                                @"hello",@"world",@"木懂懂",@"oscar",@"帅",@"mddoscar",
                                nil];
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
    [self.tableView reloadData];
#else
    //这个是手机通讯录数据
    [ServerForAddressBook getAddressBooks:^(NSArray *addressBooks) {
//        for (MddAddressBean * obj in addressBooks) {
//            [stringsToSort addObject:obj.mFamilyName];
//        }
        gAddressBookList=[addressBooks mutableCopy];
        [self doReloadData];
    } failure:^{
        NSLog(@"失败");
    }];
#endif
}
//刷新界面
-(void) doReloadData
{
    NSMutableArray *stringsToSort=[NSMutableArray array];
    for (MddAddressBean * obj in gAddressBookList) {
        //如果空则用空格
        NSString * tNumber=@"";
        if(obj.mPhoneNumbers&&[obj.mPhoneNumbers count]>0)
        {
           tNumber= [obj.mPhoneNumbers objectAtIndex:0];
        }
       NSString * tName= [NSString stringWithFormat:@"%@%@:%@",obj.mFamilyName,obj.mGivenName,tNumber];
        if ([@"" isEqualToString:tName]) {
            tName=@"未知";
        }
        [stringsToSort addObject:tName];
    }
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section];
    return key;
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lab.backgroundColor =[UIColor blackColor];
    lab.text = [indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}
#pragma mark - row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title===%@",title);
    return index;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [indexArray count];
}
#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.LetterResultArr objectAtIndex:section] count];
}
#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    #if kTestMode
        cell.textLabel.text =[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    #else
    NSString * tStr= [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    //分割
    NSArray * tArr=[tStr componentsSeparatedByString:@":"];
    if (tArr&&[tArr count]>1) {
        cell.textLabel.text =[tArr objectAtIndex:0];
        cell.detailTextLabel.text=[tArr objectAtIndex:1];
    }
    #endif
    

    
    //[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - Select内容为数组相应索引的值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---->%@",[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
#if kTestMode
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
#else
    NSString * tStr=[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSString * tNumber=@"";
    //分割
    NSArray * tArr=[tStr componentsSeparatedByString:@":"];
    if (tArr&&[tArr count]>1) {
        tNumber=[tArr objectAtIndex:1];
    }
    //kvc回传跳转
    [self doBackWithString:tNumber];
#endif

}
//回传数据
-(void) doBackWithString:(NSString *) pStr
{
    //跳转
    UIViewController *setBackViewController= [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    //设置kvc设置值
    [setBackViewController setValue:pStr forKey:@"mSimNumber"];
    //使用popToViewController返回并传值到上一页面
    [self.navigationController popToViewController:setBackViewController animated:true];
}

+ (instancetype)initializeForNib{
    return  [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end

