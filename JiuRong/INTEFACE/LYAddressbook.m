//
//  LYAddressbook.m
//  JiuRong
//
//  Created by iMac on 15/10/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "LYAddressbook.h"
#import <AddressBook/AddressBook.h>

@implementation LYAddressbook
{
    NSMutableArray *m_pArrAddressbook;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        m_pArrAddressbook = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)GetAddressbookData
{
    [m_pArrAddressbook removeAllObjects];
    
    ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
    //获取通讯录权限
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    dispatch_release(sema);
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        NSMutableDictionary *dicItem = [[NSMutableDictionary alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil)
        {
            nameString = (__bridge NSString *)abFullName;
        }
        else
        {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        [dicItem setObject:nameString forKey:@"userName"];
        [dicItem setObject:@"2" forKey:@"driverType"];
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties)/sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++)
        {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil)
                valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0)
            {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++)
            {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j)
                {
                    case 0:
                    {
                        // Phone number
                        [dicItem setObject:(__bridge NSString*)value forKey:@"targetMobile"];
                        break;
                    }
                    case 1:
                    {
                        // Email
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [m_pArrAddressbook addObject:dicItem];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}
@end
