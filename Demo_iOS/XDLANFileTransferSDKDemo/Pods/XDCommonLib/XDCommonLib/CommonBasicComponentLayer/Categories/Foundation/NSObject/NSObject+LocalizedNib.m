//
//  NSObject+LocalizedNib.m
//  XDCommonLib
//
//  Created by suxinde on 16/6/20.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "NSObject+LocalizedNib.h"
#import <objc/runtime.h>

@implementation NSObject (LocalizedNib)

//localizing nib file
- (void)xd_localizeForNib
{
    if ([self isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem *item = (UIBarButtonItem *)self;
        if (item.title.length > 0) {
            item.title = [[NSBundle mainBundle] localizedStringForKey:item.title value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UINavigationItem class]]) {
        UINavigationItem *item = (UINavigationItem *)self;
        if (item.title.length > 0) {
            item.title = [[NSBundle mainBundle] localizedStringForKey:item.title value:@"" table:nil];
        }
        if (item.prompt.length > 0) {
            item.prompt = [[NSBundle mainBundle] localizedStringForKey:item.prompt value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        if (label.text.length > 0) {
            label.text = [[NSBundle mainBundle] localizedStringForKey:label.text value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UISearchBar class]]) {
        UISearchBar *bar = (UISearchBar *)self;
        if (bar.text.length > 0) {
            bar.text = [[NSBundle mainBundle] localizedStringForKey:bar.text value:@"" table:nil];
        }
        if (bar.placeholder.length > 0) {
            bar.placeholder = [[NSBundle mainBundle] localizedStringForKey:bar.placeholder value:@"" table:nil];
        }
        if (bar.prompt.length > 0) {
            bar.prompt = [[NSBundle mainBundle] localizedStringForKey:bar.prompt value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *textfield = (UITextField *)self;
        if (textfield.text.length > 0) {
            textfield.text = [[NSBundle mainBundle] localizedStringForKey:textfield.text value:@"" table:nil];
        }
        if (textfield.placeholder.length > 0) {
            textfield.placeholder = [[NSBundle mainBundle] localizedStringForKey:textfield.placeholder value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *textview = (UITextView *)self;
        if (textview.text.length > 0) {
            textview.text = [[NSBundle mainBundle] localizedStringForKey:textview.text value:@"" table:nil];
        }
    }
    else if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        NSArray *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled), @(UIControlStateSelected), @(UIControlStateApplication)];
        for (NSNumber *state in states) {
            NSString *title = [btn titleForState:state.integerValue];
            if (title.length > 0) {
                [btn setTitle:[[NSBundle mainBundle] localizedStringForKey:title value:@"" table:nil] forState:state.integerValue];
            }
        }
    }
}


#pragma mark - Method swizzling

+ (void)load
{
    Method awakeFromNibOriginal = class_getInstanceMethod(self, @selector(awakeFromNib));
    Method xd_awakeFromNibCustomLocalized = class_getInstanceMethod(self, @selector(xd_awakeFromNibCustomLocalized));
    //Swizzle methods
    method_exchangeImplementations(awakeFromNibOriginal, xd_awakeFromNibCustomLocalized);
}

- (void)xd_awakeFromNibCustomLocalized {
    //Call standard methods
    [self xd_awakeFromNibCustomLocalized];
    
    //Localize
    [self xd_localizeForNib];
}


@end
