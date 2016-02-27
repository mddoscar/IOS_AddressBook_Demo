//
//  ServerForAddressBook.m
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import "ServerForAddressBook.h"

//屏幕高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
//获取IOS版本
//引入通讯录
#define IOS_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
//引用通讯录实体
#import "MddAddressBean.h"

////ios 9才引用效果
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//        //9.0以后
//        #import <Contacts/Contacts.h>
//        #import <ContactsUI/ContactsUI.h>
//#else
//    //9.0之前
//    #import <AddressBook/AddressBook.h>
//    #import <AddressBookUI/AddressBookUI.h>
//#endif
@implementation ServerForAddressBook

//-(NSMutableArray *)getAddressBook
//{
//    NSMutableArray * rArray=[NSMutableArray array];
//    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
//    //ios 7以下
//    CFErrorRef *error = nil;
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
//    
//    __block BOOL accessGranted = NO;
//    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//            accessGranted = granted;
//            dispatch_semaphore_signal(sema);
//        });
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        
//    }
//    else { // we're on iOS 5 or older
//        accessGranted = YES;
//    }
//    
//    ABAddressBookRef adbk =ABAddressBookCreate();//获取本地通讯录数据库
//    ABRecordRef moi=NULL;//联系人
//    ABRecordRef annkey=ABPersonCreate();//创建联系人
//    //设置联系人的值
//    
//    ABRecordSetValue(annkey,kABPersonFirstNameProperty, @"annkey", NULL);
//    ABRecordSetValue(annkey,kABPersonLastNameProperty, @"hu", NULL);
//    //创建多值属性
//    ABMutableMultiValueRef addr=ABMultiValueCreateMutable(kABStringPropertyType);
//    //增加属性名和属性值，属性名为kABHomeLabel
//    ABMultiValueAddValueAndLabel(addr, @"annkey@qq.con", kABHomeLabel, NULL);
//    //设置联系人的多值邮箱属性
//    ABRecordSetValue(annkey, kABPersonEmailProperty, addr, NULL);
//    
//    ABAddressBookAddRecord(adbk, annkey, NULL); //增加联系人
//    ABAddressBookSave(adbk, NULL);//保存联系人
//    
//    CFRelease(addr);
//    CFRelease(annkey);//，即使是在arc机制里，c对象仍需手动释放
//    
//    CFArrayRef sams=ABAddressBookCopyPeopleWithName(adbk, (CFStringRef)@"hu");//联系人数组，可能存在多个同名的联系人，需要通过其他属性来判断具体是哪个
//    for (CFIndex ix=0; ix<CFArrayGetCount(sams); ix++) {
//        
//        // 从联系人数组多个sam中读取
//        ABRecordRef sam=CFArrayGetValueAtIndex(sams, ix);
//        //  获取联系人的名属性
//        CFStringRef last=ABRecordCopyValue(sam, kABPersonLastNameProperty);
//        NSLog(@" is find %@",last);
//        //找到符合条件的联系人
//        if (last&&CFStringCompare(last, (CFStringRef)@"annkey", 0)==0) {
//            moi=sam;
//        }
//        if (last) {
//            
//            CFRelease(last);  //c对象需手动释放
//        }
//        
//    }
//    if (NULL==moi) {
//        
//        CFRelease(sams);
//        CFRelease(adbk);//c对象需手动释放
////        return;
////        break;
//    }
//    //获取联系人的邮件属性，初始化为多值
//    ABMultiValueRef emails=ABRecordCopyValue(moi, kABPersonEmailProperty);
//    if (NULL==emails) {
//        NSLog(@"emails is null");
//    }
//    for (CFIndex ix=0; ix<ABMultiValueGetCount(emails); ix++) {
//        //联系人的属性名和属性值
//        CFStringRef labe1=ABMultiValueCopyLabelAtIndex(emails, ix);
//        CFStringRef value=ABMultiValueCopyValueAtIndex(emails, ix);
//        NSLog(@"i have a %@ address I%@",labe1,value);
//        CFRelease(labe1);
//        CFRelease(value);
//    }
//    NSLog(@"emails is null2");
//    CFRelease(emails);
//    CFRelease(sams);
//    CFRelease(adbk);
//
//     #if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
//    
//    
//    
//    
//    
//        #elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
//    //ios [8~9)
//    
//    #else
//    //ios [9+)
//    
//    #endif
//#endif
////#else
//    return rArray;
//
//}
+ (void)getAddressBooks:(void (^)(NSArray *addressBooks))successBlock failure:(void (^)())failureBlock
{
    NSMutableArray *contects = [[NSMutableArray alloc] init];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        CNContactStore *store = [[CNContactStore alloc] init];
        
//        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactFamilyNameKey,CNContactGivenNameKey, CNContactPhoneNumbersKey]];
                CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactIdentifierKey,CNContactNamePrefixKey, CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey,CNContactPreviousFamilyNameKey,CNContactNameSuffixKey,CNContactNicknameKey,CNContactPhoneticGivenNameKey,CNContactPhoneticMiddleNameKey,CNContactPhoneticFamilyNameKey,CNContactOrganizationNameKey,CNContactDepartmentNameKey,CNContactJobTitleKey,CNContactBirthdayKey,CNContactNonGregorianBirthdayKey,CNContactNoteKey,CNContactTypeKey,CNContactPhoneNumbersKey]];
        NSError *error = nil;
        
        //        NSMutableArray *names = [[NSMutableArray alloc] init];
        //        NSMutableArray *phones = [[NSMutableArray alloc] init];
        
        //执行获取通讯录请求，若通讯录可获取，flag为YES，代码块也会执行，若获取失败，flag为NO，代码块不执行
        BOOL flag = [store enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            //去除数字以外的所有字符
            NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                           invertedSet ];
            //            NSString *strPhone = @"";
            //            if (contact.phoneNumbers.count>0) {
            //                strPhone  = [[[contact.phoneNumbers firstObject].value.stringValue componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
            //            }
            //            [phones addObject:strPhone];
            //            NSString *name = @"";
            //            if ([NSString stringWithFormat:@"%@ %@",contact.familyName,contact.givenName]) {
            //                name =  [NSString stringWithFormat:@"%@ %@",contact.familyName,contact.givenName];
            //            }
            //            [names addObject:name];
            
            MddAddressBean *addressBook = [[MddAddressBean alloc] init];
            //设置版本
            [addressBook setMSysVersion:[NSString stringWithFormat:@"%f",IOS_VERSION]];
            
            if (contact.familyName) {
                addressBook.mFamilyName = contact.familyName;
            }
            
            if (contact.givenName) {
                addressBook.mGivenName = contact.givenName;
            }
            //其他字段
            if(contact.contactType==CNContactTypePerson)
            {
                addressBook.mI9_contactType=addressBook.getCNContactTypePersonStr;
            }else  if(contact.contactType==CNContactTypeOrganization){
                addressBook.mI9_contactType=addressBook.getCNContactTypeOrganizationStr;
            }
            if (contact.namePrefix) {
                addressBook.mI9_namePrefix=contact.namePrefix;
            }
            if (contact.givenName) {
                addressBook.mI9_givenName=contact.givenName;
            }
            if (contact.middleName) {
                addressBook.mI9_middleName=contact.middleName;
            }
            if (contact.familyName) {
                addressBook.mI9_familyName=contact.familyName;
            }
            
            if (contact.previousFamilyName) {
                addressBook.mI9_previousFamilyName=contact.previousFamilyName;
            }
            if (contact.nameSuffix) {
                addressBook.mI9_nameSuffix=contact.nameSuffix;
            }
            if (contact.nickname) {
                addressBook.mI9_nickname=contact.nickname;
            }
            if (contact.phoneticGivenName) {
                addressBook.mI9_phoneticGivenName=contact.phoneticGivenName;
            }
            if (contact.phoneticMiddleName) {
                addressBook.mI9_phoneticMiddleName=contact.phoneticMiddleName;
            }
            if (contact.phoneticFamilyName) {
                addressBook.mI9_phoneticFamilyName=contact.phoneticFamilyName;
            }
            if (contact.organizationName) {
                addressBook.mI9_organizationName=contact.organizationName;
            }
            if (contact.departmentName) {
                addressBook.mI9_departmentName=contact.departmentName;
            }
            if (contact.jobTitle) {
                addressBook.mI9_jobTitle=contact.jobTitle;
            }
            if (contact.departmentName) {
                addressBook.mI9_note=contact.note;
            }
            
            if (contact.phoneNumbers.count > 0) {
                NSMutableArray *phones = [[NSMutableArray alloc] init];
                for (CNLabeledValue *phoneNumber in contact.phoneNumbers) {
                    [phones addObject:[[[phoneNumber.value stringValue] componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""]];
                }
                
                addressBook.mPhoneNumbers = phones.copy;
            }
            
            [contects addObject:addressBook];
            
        }];
        
        if (flag) {
            //            NSLog(@"手机号%@",[phones componentsJoinedByString:@","]);
            //            NSLog(@"名字%@",[names componentsJoinedByString:@","]);
            if (successBlock) {
                successBlock(contects.copy);
            }
        } else {
            if (failureBlock) {
                failureBlock();
            }
        }
        
    } else {
        
        NSMutableArray *names = [[NSMutableArray alloc] init];
        NSMutableArray *phones = [[NSMutableArray alloc]init];
        CFErrorRef *error = nil;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        __block BOOL accessGranted = NO;
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        if (accessGranted) {
            
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople (addressBook);
            CFIndex nPeople = ABAddressBookGetPersonCount (addressBook);
            
            for ( NSInteger i = 0 ; i < nPeople; i++)
            {
                ABRecordRef person = CFArrayGetValueAtIndex (allPeople, i);
                NSString *givenName = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNameProperty ));
                NSString *familyName = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNameProperty ));
                //其他字段
                
                
                
                ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
                NSArray *array = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumbers));
                NSString *phoneNumber = @"";
                if (array.count > 0) {
                    phoneNumber = [array firstObject];
                }
                
                //                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",familyName,givenName],@"name",phoneNumber,@"phone",[NSNumber numberWithBool:NO],@"isUser",nil];
                //去除数字以外的所有字符
                NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                               invertedSet ];
                NSString *strPhone = [[phoneNumber componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
                [phones addObject:strPhone];
                NSString *name = [NSString stringWithFormat:@"%@%@",familyName,givenName];
                [names addObject:name];
                
                MddAddressBean *addressBook = [[MddAddressBean alloc] init];
                [addressBook setMSysVersion:[NSString stringWithFormat:@"%f",IOS_VERSION]];
                [addressBook.mPhoneNumbers addObject:strPhone];
                addressBook.mFamilyName=familyName;
                addressBook.mGivenName=givenName;
                //其他
                addressBook.mI8_kABPersonFirstNameProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNameProperty ));
                 addressBook.mI8_kABPersonLastNameProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNameProperty ));
                 addressBook.mI8_kABPersonMiddleNameProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonMiddleNameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonMiddleNameProperty ));
                 addressBook.mI8_kABPersonPrefixProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonPrefixProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonPrefixProperty ));
                 addressBook.mI8_kABPersonSuffixProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonSuffixProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonSuffixProperty ));
                 addressBook.mI8_kABPersonNicknameProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonNicknameProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonNicknameProperty ));
                 addressBook.mI8_kABPersonFirstNamePhoneticProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNamePhoneticProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonFirstNamePhoneticProperty ));
                 addressBook.mI8_kABPersonLastNamePhoneticProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNamePhoneticProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonLastNamePhoneticProperty ));
                 addressBook.mI8_kABPersonMiddleNamePhoneticProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonMiddleNamePhoneticProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonMiddleNamePhoneticProperty ));
                 addressBook.mI8_kABPersonOrganizationProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonOrganizationProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonOrganizationProperty ));
                 addressBook.mI8_kABPersonDepartmentProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonDepartmentProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonDepartmentProperty ));
                 addressBook.mI8_kABPersonJobTitleProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonJobTitleProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonJobTitleProperty ));
                 addressBook.mI8_kABPersonEmailProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonEmailProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonEmailProperty ));
                 addressBook.mI8_kABPersonBirthdayProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonBirthdayProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonBirthdayProperty ));
                 addressBook.mI8_kABPersonNoteProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonNoteProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonNoteProperty ));
                 addressBook.mI8_kABPersonCreationDateProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonCreationDateProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonCreationDateProperty ));
                 addressBook.mI8_kABPersonModificationDateProperty = (__bridge NSString *)(ABRecordCopyValue (person, kABPersonModificationDateProperty )) == nil ? @"" : (__bridge NSString *)(ABRecordCopyValue (person, kABPersonModificationDateProperty ));
                
                [contects addObject:addressBook];
                
            }
            //回调
            if (successBlock) {
                successBlock(contects.copy);
            }
            
            NSLog(@"手机号%@",[phones componentsJoinedByString:@","]);
            NSLog(@"名字%@",[names componentsJoinedByString:@","]);
        }
    }
}


@end
