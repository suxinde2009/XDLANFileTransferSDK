//
//  XDAddressBookManager.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/10.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XDAddressBookManager : NSObject

/**
 *  Get name of contact with specific phone number.
 *
 *  @param phoneNumber Phone number for the contact.
 *
 *  @return Name of contact.
 */
+ (NSString *)nameForContactWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  Get photo of contact with specific phone number.
 *
 *  @param phoneNumber Phone number for the contact.
 *
 *  @return Photo of contact.
 */
+ (UIImage *)photoForContactWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  Get name of contact with specific email address.
 *
 *  @param emailAddress Email address for the contact.
 *
 *  @return Name of contact.
 */
+ (NSString *)nameForContactWithEmailAddress:(NSString *)emailAddress;

/**
 *  Get photo of contact with specific email address.
 *
 *  @param emailAddress Email address for the contact.
 *
 *  @return Photo of contact.
 */
+ (UIImage *)photoForContactWithEmailAddress:(NSString *)emailAddress;

@end
