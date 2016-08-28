//
//  XDABStandin.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/15.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#define kAuthorizationUpdateNotification @"ABAuthorizationNotification"

@interface XDABStandin : NSObject

+ (ABAddressBookRef) addressBook;
+ (ABAddressBookRef) currentAddressBook;
+ (BOOL) save: (NSError **) error;
+ (BOOL) authorized;
+ (ABAuthorizationStatus) authorizationStatus;
+ (void) requestAccess;
+ (void) showDeniedAccessAlert;

@end
