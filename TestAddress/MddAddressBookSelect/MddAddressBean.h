//
//  MddAddressBean.h
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 通讯录实体
 */
@interface MddAddressBean : NSObject

#pragma mark data
//主要属性
@property (nonatomic, copy) NSString *mFamilyName;
@property (nonatomic, copy) NSString *mGivenName;
@property (nonatomic, copy) NSMutableArray  *mPhoneNumbers;
//其他属性（ios 9）
@property (nonatomic, copy) NSString *mI9_identifier;
//@property (nonatomic, assign) CNContactType mI9_contactType;
@property (nonatomic, copy) NSString *mI9_contactType;
@property (nonatomic, copy) NSString *mI9_namePrefix;
@property (nonatomic, copy) NSString *mI9_givenName;
@property (nonatomic, copy) NSString *mI9_middleName;
@property (nonatomic, copy) NSString *mI9_familyName;
@property (nonatomic, copy) NSString *mI9_previousFamilyName;
@property (nonatomic, copy) NSString *mI9_nameSuffix;
@property (nonatomic, copy) NSString *mI9_nickname;

@property (nonatomic, copy) NSString *mI9_phoneticGivenName;
@property (nonatomic, copy) NSString *mI9_phoneticMiddleName;
@property (nonatomic, copy) NSString *mI9_phoneticFamilyName;

@property (nonatomic, copy) NSString *mI9_organizationName;
@property (nonatomic, copy) NSString *mI9_departmentName;
@property (nonatomic, copy) NSString *mI9_jobTitle;
@property (nonatomic, copy) NSString *mI9_note;
//其他属性（ios 8）
@property (nonatomic, copy) NSString *mI8_kABPersonFirstNameProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonLastNameProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonMiddleNameProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonPrefixProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonSuffixProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonNicknameProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonFirstNamePhoneticProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonLastNamePhoneticProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonMiddleNamePhoneticProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonOrganizationProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonDepartmentProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonJobTitleProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonEmailProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonBirthdayProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonNoteProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonCreationDateProperty;
@property (nonatomic, copy) NSString *mI8_kABPersonModificationDateProperty;

//标志位(系统版本)
@property (nonatomic,copy) NSString * mSysVersion;
@property(nonatomic,assign)BOOL mIsIoS9;//是否大于ios9


#pragma mark ctor
-(id) initWithDataFamilyname:(NSString *)pFamilyName mGivenName:(NSString *)pGivenName mPhoneNumbers:(NSMutableArray *)pPhoneNumbers;
-(id) initWithDataFamilyname:(NSString *)pFamilyName mGivenName:(NSString *)pGivenName mPhoneNumbers:(NSMutableArray *)pPhoneNumbers mSysVersion:(NSString *) pSysVersion mIsIoS9:(BOOL) pIsIoS9;
#pragma mark func
-(void) setSysVersionStr:(NSString *) pSysVersionStr;
-(void) setSysVersionNumber:(float) pSysVersionNumber;
-(NSString *) description;
-(NSString *) getCNContactTypePersonStr;
-(NSString *) getCNContactTypeOrganizationStr;

@end
