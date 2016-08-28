//
//  NSArray+XDCommonLib.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XDCommonLib)

- (id _Nullable)safeObjectAtIndex:(NSUInteger)index;

/**
 *  Create a reversed array from self
 *
 *  @return Returns the reversed array
 */
- (NSArray * _Nonnull)reversedArray;

/**
 *  Convert self to JSON as NSString
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)arrayToJson;

/**
 *  Simulates the array as a circle. When it is out of range, begins again
 *
 *  @param index The index
 *
 *  @return Returns the object at a given index
 */
- (id _Nullable)objectAtCircleIndex:(NSInteger)index;

/**
 *  Create a reversed array from the given array
 *
 *  @param array The array to be converted
 *
 *  @return Returns the reversed array
 */
+ (NSArray * _Nonnull)reversedArray:(NSArray * _Nonnull)array;

/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)arrayToJson:(NSArray * _Nonnull)array;


@end
