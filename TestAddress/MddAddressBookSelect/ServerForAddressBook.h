//
//  ServerForAddressBook.h
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 通讯录服务
 */
@interface ServerForAddressBook : NSObject

//获取通讯录
//-(NSMutableArray *) getAddressBook;

+ (void)getAddressBooks:(void(^)(NSArray *addressBooks))successBlock failure:(void(^)())failureBlock;

@end
