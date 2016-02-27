//
//  MddAddressBean.m
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import "MddAddressBean.h"


#ifndef MddAddress_MddAddressBean_h
#define MddAddress_MddAddressBean_h
#define IOS_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#endif
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif
//电话类型
#define kCNContactTypePerson @"CNContactTypePerson"
#define kCNContactTypeOrganization @"CNContactTypeOrganization"

@implementation MddAddressBean
@synthesize mFamilyName=_mFamilyName;
@synthesize mGivenName=_mGivenName;
@synthesize mPhoneNumbers=_mPhoneNumbers;
@synthesize mIsIoS9=_mIsIoS9;
@synthesize mSysVersion=_mSysVersion;
//ios 8
@synthesize mI8_kABPersonCreationDateProperty=_mI8_kABPersonCreationDateProperty;
@synthesize mI8_kABPersonDepartmentProperty=_mI8_kABPersonDepartmentProperty;
@synthesize mI8_kABPersonEmailProperty=_mI8_kABPersonEmailProperty;
@synthesize mI8_kABPersonFirstNamePhoneticProperty=_mI8_kABPersonFirstNamePhoneticProperty;
@synthesize mI8_kABPersonFirstNameProperty=_mI8_kABPersonFirstNameProperty;
@synthesize mI8_kABPersonJobTitleProperty=_mI8_kABPersonJobTitleProperty;
@synthesize mI8_kABPersonLastNamePhoneticProperty=_mI8_kABPersonLastNamePhoneticProperty;
@synthesize mI8_kABPersonLastNameProperty=_mI8_kABPersonLastNameProperty;
@synthesize mI8_kABPersonMiddleNamePhoneticProperty=_mI8_kABPersonMiddleNamePhoneticProperty;
@synthesize mI8_kABPersonMiddleNameProperty=_mI8_kABPersonMiddleNameProperty;
@synthesize mI8_kABPersonModificationDateProperty=_mI8_kABPersonModificationDateProperty;
@synthesize mI8_kABPersonNicknameProperty=_mI8_kABPersonNicknameProperty;
@synthesize mI8_kABPersonNoteProperty=_mI8_kABPersonNoteProperty;
@synthesize mI8_kABPersonOrganizationProperty=_mI8_kABPersonOrganizationProperty;
@synthesize mI8_kABPersonPrefixProperty=_mI8_kABPersonPrefixProperty;
@synthesize mI8_kABPersonSuffixProperty=_mI8_kABPersonSuffixProperty;
//ios 9(16字段)
@synthesize mI9_contactType=_mI9_contactType;
@synthesize mI9_departmentName=_mI9_departmentName;
@synthesize mI9_familyName=_mI9_familyName;
@synthesize mI9_givenName=_mI9_givenName;
@synthesize mI9_identifier=_mI9_identifier;
@synthesize mI9_jobTitle=_mI9_jobTitle;
@synthesize mI9_middleName=_mI9_middleName;
@synthesize mI9_namePrefix=_mI9_namePrefix;
@synthesize mI9_nameSuffix=_mI9_nameSuffix;
@synthesize mI9_nickname=_mI9_nickname;
@synthesize mI9_note=_mI9_note;
@synthesize mI9_organizationName=_mI9_organizationName;
@synthesize mI9_phoneticFamilyName=_mI9_phoneticFamilyName;
@synthesize mI9_phoneticGivenName=_mI9_phoneticGivenName;
@synthesize mI9_phoneticMiddleName=_mI9_phoneticMiddleName;
@synthesize mI9_previousFamilyName=_mI9_previousFamilyName;


//默认构造函数
-(id)init
{
    if (self=[super init]) {
        _mFamilyName=@"";
        _mGivenName=@"";
        _mPhoneNumbers=[NSMutableArray array];
        _mSysVersion=[NSString stringWithFormat:@"%f",IOS_VERSION];
        _mIsIoS9=(IOS_VERSION>=9.0);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        //9.0以后
        [self doIos9Def];
#else
        //9.0之前
        [self doIos8Def];
#endif
    }
    return self;
}
-(id) initWithDataFamilyname:(NSString *)pFamilyName mGivenName:(NSString *)pGivenName mPhoneNumbers:(NSMutableArray *)pPhoneNumbers
{
    if (self=[super init]) {
        _mFamilyName=pFamilyName;
        _mGivenName=pGivenName;
        _mPhoneNumbers=pPhoneNumbers;
        _mSysVersion=[NSString stringWithFormat:@"%f",IOS_VERSION];
        _mIsIoS9=(IOS_VERSION>=9.0);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        //9.0以后
        [self doIos9Def];
#else
        //9.0之前
        [self doIos8Def];
#endif
    }
    return self;
}
-(id) initWithDataFamilyname:(NSString *)pFamilyName mGivenName:(NSString *)pGivenName mPhoneNumbers:(NSMutableArray *)pPhoneNumbers mSysVersion:(NSString *) pSysVersion mIsIoS9:(BOOL) pIsIoS9
{
    if (self=[super init]) {
        _mFamilyName=pFamilyName;
        _mGivenName=pGivenName;
        _mPhoneNumbers=pPhoneNumbers;
        _mSysVersion=pSysVersion;
        _mIsIoS9=pIsIoS9;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        //9.0以后
        [self doIos9Def];
#else
        //9.0之前
        [self doIos8Def];
#endif
    }
    return self;
}

#pragma mark func
-(void) setSysVersionStr:(NSString *) pSysVersionStr
{
    _mSysVersion=pSysVersionStr;
    _mIsIoS9=([pSysVersionStr floatValue]>=9.0);
    
}
-(void) setSysVersionNumber:(float) pSysVersionNumber
{
    _mSysVersion=[NSString stringWithFormat:@"%f",pSysVersionNumber ];
    _mIsIoS9=(pSysVersionNumber>=9.0);
}
-(NSString *) description
{
    NSString * rSysString=@"";
    
    //ios 9才引用效果
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    rSysString=[NSString stringWithFormat:@"contactType:%@,departmentName:%@,familyName:%@,_mI9_givenName:%@,identifier:%@,jobTitle:%@,middleName:%@,namePrefix:%@,nameSuffix:%@,nickname:%@,note:%@,organizationName:%@,phoneticFamilyName:%@,phoneticGivenName:%@,phoneticMiddleName:%@,previousFamilyName:%@",_mI9_contactType,_mI9_departmentName,_mI9_familyName,_mI9_givenName,_mI9_identifier,_mI9_jobTitle,_mI9_middleName,_mI9_namePrefix,_mI9_nameSuffix,_mI9_nickname,_mI9_note,_mI9_organizationName,_mI9_phoneticFamilyName,_mI9_phoneticGivenName,_mI9_phoneticMiddleName,_mI9_previousFamilyName];
    //9.0以后
    return [NSString stringWithFormat:@"{mFamilyName:%@,mGivenName:%@,mPhoneNumbers:%@,mIsIoS9:%@,mSysVersion:%@,other:%@}",_mFamilyName,_mGivenName,_mPhoneNumbers,_mIsIoS9?@"Y":@"N",_mSysVersion,rSysString];
#else
    rSysString=[NSString stringWithFormat:@"kABPersonBirthdayProperty:%@,kABPersonCreationDateProperty:%@,_mI8_kABPersonDepartmentProperty:%@,_mI8_kABPersonEmailProperty:%@,_mI8_kABPersonFirstNamePhoneticProperty:%@,_mI8_kABPersonFirstNameProperty:%@,_mI8_kABPersonFirstNameProperty:%@,_mI8_kABPersonJobTitleProperty:%@,_mI8_kABPersonLastNamePhoneticProperty:%@,_mI8_kABPersonLastNameProperty:%@,_mI8_kABPersonMiddleNamePhoneticProperty:%@,_mI8_kABPersonMiddleNameProperty:%@,_mI8_kABPersonModificationDateProperty:%@,_mI8_kABPersonNicknameProperty:%@,_mI8_kABPersonNoteProperty:%@,_mI8_kABPersonOrganizationProperty:%@,_mI8_kABPersonPrefixProperty:%@",_mI8_kABPersonBirthdayProperty,_mI8_kABPersonCreationDateProperty,_mI8_kABPersonDepartmentProperty,_mI8_kABPersonEmailProperty,_mI8_kABPersonFirstNamePhoneticProperty,_mI8_kABPersonFirstNameProperty,_mI8_kABPersonJobTitleProperty,_mI8_kABPersonLastNamePhoneticProperty,_mI8_kABPersonLastNameProperty,_mI8_kABPersonMiddleNamePhoneticProperty,_mI8_kABPersonMiddleNameProperty,_mI8_kABPersonModificationDateProperty,_mI8_kABPersonNicknameProperty,_mI8_kABPersonNoteProperty,_mI8_kABPersonOrganizationProperty,_mI8_kABPersonPrefixProperty,_mI8_kABPersonSuffixProperty];
    //9.0之前
    return [NSString stringWithFormat:@"{mFamilyName:%@,mGivenName:%@,mPhoneNumbers:%@,mIsIoS9:%@,mSysVersion:%@,other:%@}",_mFamilyName,_mGivenName,_mPhoneNumbers,_mIsIoS9?@"Y":@"N",_mSysVersion,rSysString];
#endif
}
-(NSString *) getCNContactTypePersonStr
{
    return kCNContactTypePerson;
}
-(NSString *) getCNContactTypeOrganizationStr
{
    return kCNContactTypeOrganization;
}
#pragma mark private
-(void) doIos8Def
{
    _mI8_kABPersonBirthdayProperty=@"";
    _mI8_kABPersonCreationDateProperty=@"";
    _mI8_kABPersonDepartmentProperty=@"";
    _mI8_kABPersonEmailProperty=@"";
    _mI8_kABPersonFirstNamePhoneticProperty=@"";
    _mI8_kABPersonFirstNameProperty=@"";
    _mI8_kABPersonJobTitleProperty=@"";
    _mI8_kABPersonLastNamePhoneticProperty=@"";
    _mI8_kABPersonLastNameProperty=@"";
    _mI8_kABPersonMiddleNamePhoneticProperty=@"";
    _mI8_kABPersonMiddleNameProperty=@"";
    _mI8_kABPersonModificationDateProperty=@"";
    _mI8_kABPersonNicknameProperty=@"";
    _mI8_kABPersonNoteProperty=@"";
    _mI8_kABPersonOrganizationProperty=@"";
    _mI8_kABPersonPrefixProperty=@"";
    _mI8_kABPersonSuffixProperty=@"";
}
-(void) doIos9Def
{
    _mI8_kABPersonBirthdayProperty=@"";
    _mI8_kABPersonCreationDateProperty=@"";
    _mI8_kABPersonDepartmentProperty=@"";
    _mI8_kABPersonEmailProperty=@"";
    _mI8_kABPersonFirstNamePhoneticProperty=@"";
    _mI8_kABPersonFirstNameProperty=@"";
    _mI8_kABPersonJobTitleProperty=@"";
    _mI8_kABPersonLastNamePhoneticProperty=@"";
    _mI8_kABPersonLastNameProperty=@"";
    _mI8_kABPersonMiddleNamePhoneticProperty=@"";
    _mI8_kABPersonMiddleNameProperty=@"";
    _mI8_kABPersonModificationDateProperty=@"";
    _mI8_kABPersonNicknameProperty=@"";
    _mI8_kABPersonNoteProperty=@"";
    _mI8_kABPersonOrganizationProperty=@"";
    _mI8_kABPersonPrefixProperty=@"";
    _mI8_kABPersonSuffixProperty=@"";
}
@end
