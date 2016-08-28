//
//  XDABContactsHelper.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/15.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDABContactsHelper.h"
#import "XDABStandin.h"

@implementation XDABContactsHelper

#pragma mark Address Book

+ (ABAddressBookRef) addressBook
{
    return [XDABStandin addressBook];
}

+ (void) refresh
{
    [XDABStandin currentAddressBook];
}

+ (NSArray *) contacts
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    NSArray *thePeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:thePeople.count];
    for (id person in thePeople)
        [array addObject:[XDABContactEntity contactWithRecord:(__bridge ABRecordRef)person]];
    return array;
}

+ (int) contactsCount
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    return ABAddressBookGetPersonCount(addressBook);
}

+ (int) contactsWithImageCount
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    NSArray *thePeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    int ncount = 0;
    for (id person in thePeople)
    {
        ABRecordRef abPerson = (__bridge ABRecordRef) person;
        if (ABPersonHasImageData(abPerson)) ncount++;
    }
    return ncount;
}

+ (int) contactsWithoutImageCount
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    NSArray *thePeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    int ncount = 0;
    for (id person in thePeople)
    {
        ABRecordRef abPerson = (__bridge ABRecordRef) person;
        if (!ABPersonHasImageData(abPerson)) ncount++;
    }
    return ncount;
}

// Groups
+ (int) numberOfGroups
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    NSArray *groups = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllGroups(addressBook);
    int ncount = groups.count;
    return ncount;
}

+ (NSArray *) groups
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    NSArray *groups = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllGroups(addressBook);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:groups.count];
    for (id group in groups)
    {
        ABRecordRef abGroup = (__bridge ABRecordRef) group;
        [array addObject:[XDABGroup groupWithRecord:abGroup]];
    }
    return array;
}

#pragma mark Sorting

// Sorting
+ (BOOL) firstNameSorting
{
    return (ABPersonGetCompositeNameFormat() == kABPersonCompositeNameFormatFirstNameFirst);
}

#pragma mark Contact Management

// Thanks to Eridius for suggestions re: error
+ (BOOL) addContact: (XDABContactEntity *) aContact withError: (NSError **) error
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    BOOL success;
    CFErrorRef errorRef = NULL;
    
    if (!aContact) return NO;
    
    success = ABAddressBookAddRecord(addressBook, aContact.record, &errorRef);
    if (!success)
    {
        if (error)
            *error = (__bridge_transfer NSError *)errorRef;
        return NO;
    }
    
    return YES;
}

+ (BOOL) addGroup: (XDABGroup *) aGroup withError: (NSError **) error
{
    ABAddressBookRef addressBook = [XDABStandin addressBook];
    BOOL success;
    CFErrorRef errorRef = NULL;
    
    success = ABAddressBookAddRecord(addressBook, aGroup.record, &errorRef);
    if (!success)
    {
        if (error)
            *error = (__bridge_transfer NSError *)errorRef;
        return NO;
    }
    
    return NO;
}

#pragma mark Searches

+ (NSArray *) contactsMatchingName: (NSString *) fname
{
    NSPredicate *pred;
    NSArray *contacts = [XDABContactsHelper contacts];
    pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", fname, fname, fname, fname];
    return [contacts filteredArrayUsingPredicate:pred];
}

+ (NSArray *) contactsMatchingName: (NSString *) fname andName: (NSString *) lname
{
    NSPredicate *pred;
    NSArray *contacts = [XDABContactsHelper contacts];
    pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", fname, fname, fname, fname];
    contacts = [contacts filteredArrayUsingPredicate:pred];
    pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", lname, lname, lname, lname];
    contacts = [contacts filteredArrayUsingPredicate:pred];
    return contacts;
}

+ (NSArray *) contactsMatchingPhone: (NSString *) number
{
    NSPredicate *pred;
    NSArray *contacts = [XDABContactsHelper contacts];
    pred = [NSPredicate predicateWithFormat:@"phonenumbers contains[cd] %@", number];
    return [contacts filteredArrayUsingPredicate:pred];
}

// Thanks Frederic Bronner
+ (NSArray *) contactsMatchingOrganization: (NSString *) organization
{
    NSPredicate *pred;
    NSArray *contacts = [XDABContactsHelper contacts];
    pred = [NSPredicate predicateWithFormat:@"organization contains[cd] %@", organization];
    return [contacts filteredArrayUsingPredicate:pred];
}


+ (NSArray *) groupsMatchingName: (NSString *) fname
{
    NSPredicate *pred;
    NSArray *groups = [XDABContactsHelper groups];
    pred = [NSPredicate predicateWithFormat:@"name contains[cd] %@ ", fname];
    return [groups filteredArrayUsingPredicate:pred];
}


@end
