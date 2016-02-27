//
//  MddAddressSelectTableViewController.h
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 电话选择器
 */
@interface MddAddressSelectTableViewController : UITableViewController
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个section下的cell内容
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

#pragma mark ctor
//构造函数
+ (instancetype)initializeForNib;
@end
