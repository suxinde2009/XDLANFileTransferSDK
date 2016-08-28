//
//  XDContact.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/10.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  手机联系人实体类
 */
@interface XDContactEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSArray *emails;
@property (nonatomic, strong) UIImage *photo;


@end
