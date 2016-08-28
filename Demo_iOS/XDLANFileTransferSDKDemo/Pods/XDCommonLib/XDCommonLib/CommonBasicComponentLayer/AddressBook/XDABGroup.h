//
//  XDABGroup.h
//  XDCommonLib
//
//  Created by suxinde on 16/6/15.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>
#import "XDABContactEntity.h"

@interface XDABGroup : NSObject

+ (id) group;
+ (id) groupWithRecord: (ABRecordRef) record;
+ (id) groupWithRecordID: (ABRecordID) recordID;
- (BOOL) removeSelfFromAddressBook: (NSError **) error;

@property (nonatomic, readonly) ABRecordRef record;
@property (nonatomic, readonly) ABRecordID recordID;
@property (nonatomic, readonly) ABRecordType recordType;
@property (nonatomic, readonly) BOOL isPerson;

- (NSArray *) membersWithSorting: (ABPersonSortOrdering) ordering;
- (BOOL) addMember: (XDABContactEntity *) contact withError: (NSError **) error;
- (BOOL) removeMember: (XDABContactEntity *) contact withError: (NSError **) error;

@property (nonatomic, assign) NSString *name;
@property (nonatomic, readonly) NSArray *members;

@end
