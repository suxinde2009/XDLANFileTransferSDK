//
//  XDABContactsHelper.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/15.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "XDABContactEntity.h"
#import "XDABGroup.h"

@interface XDABContactsHelper : NSObject

// Address Book
+ (ABAddressBookRef) addressBook;
+ (void) refresh;

// Address Book Contacts and Groups
+ (NSArray *) contacts; // people
+ (NSArray *) groups; // groups

// Counting
+ (int) contactsCount;
+ (int) contactsWithImageCount;
+ (int) contactsWithoutImageCount;
+ (int) numberOfGroups;

// Sorting
+ (BOOL) firstNameSorting;

// Add contacts and groups
+ (BOOL) addContact: (XDABContactEntity *) aContact withError: (NSError **) error;
+ (BOOL) addGroup: (XDABGroup *) aGroup withError: (NSError **) error;

// Find contacts
+ (NSArray *) contactsMatchingName: (NSString *) fname;
+ (NSArray *) contactsMatchingName: (NSString *) fname andName: (NSString *) lname;
+ (NSArray *) contactsMatchingPhone: (NSString *) number;
+ (NSArray *) contactsMatchingOrganization: (NSString *) organization;

// Find groups
+ (NSArray *) groupsMatchingName: (NSString *) fname;

@end

// For the simple utility of it. Feel free to comment out if desired
@interface NSString (cstring)

@property (readonly) char *UTF8String;

@end