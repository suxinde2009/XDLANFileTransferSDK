//
//  XDAppVerObserver.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/9.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDAppVerisonUpdateObserver.h"
#import <UIKit/UIKit.h>

static NSString *const kXDAppVersionKey = @"kXDAppVersionKey";

/*
 required_version:
 The version string of latest client application.
 
 type:
 The type of update, "force" or "optional".
 
 update_url:
 The App store URL of your app.
 
 {"required_version":"2.0.0","type":"force","update_url":"https://itunes.apple.com/jp/app/idxxxxxxxxxx?mt="}
 */

@interface XDAppVerisonUpdateObserver () <UIAlertViewDelegate> {
    NSDictionary *versionInfo;
}
@end

@implementation XDAppVerisonUpdateObserver

+ (void)sycAppVerToCurrent
{
    NSString *curAppVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:curAppVer forKey:kXDAppVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isAppVersionChanged
{
    NSString *curAppVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *curAppVerInUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:kXDAppVersionKey];
    return (![curAppVer isEqualToString:curAppVerInUserDefaults]);
}


- (void)executeVersionCheck {
    NSAssert(_endPointUrl, @"Set EndPointUrl Before Execute Check");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_endPointUrl]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            versionInfo = responseObject;
            [self showUpdateAnnounceIfNeeded];
        }else {
            NSLog(@"Request Operation Error! %@", connectionError);
        }
    }];
}

- (void)showUpdateAnnounceIfNeeded {
    if( ![self isVersionUpNeeded] ) {
        return;
    }
    [self showUpdateAnnounce];
}

- (BOOL) isVersionUpNeeded {
    NSString *currentVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *requiredVersion = versionInfo[@"required_version"];
    return ( [requiredVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending );
}

- (void)showUpdateAnnounce {
    
    NSString *cancelButtonText = nil;
    UIAlertView *alert = nil;

    if([versionInfo[@"type"] isEqualToString:@"optional"]){
        cancelButtonText = [self cancelButtonText];
    }

    if (cancelButtonText == nil) {
        alert = [[UIAlertView alloc] initWithTitle:[self alertTitle] message:[self alertBody] delegate:self cancelButtonTitle:[self updateButtonText] otherButtonTitles:nil, nil];
    }else {
        alert = [[UIAlertView alloc] initWithTitle:[self alertTitle] message:[self alertBody] delegate:self cancelButtonTitle:cancelButtonText otherButtonTitles:[self updateButtonText],nil];
    }
    [alert show];
}

- (NSString *)alertTitle {
    return _customAlertTitle ? _customAlertTitle : [self localizedStringWithFormat:@"XDAppVerisonUpdateObserver.alert.title"];
}

- (NSString *)alertBody {
    return _customAlertBody ? _customAlertBody : [self localizedStringWithFormat:@"XDAppVerisonUpdateObserver.alert.body"];
}

- (NSString *)updateButtonText {
    return [self localizedStringWithFormat:@"XDAppVerisonUpdateObserver.alert.updateButton"];
}

- (NSString *)cancelButtonText {
    return [self localizedStringWithFormat:@"XDAppVerisonUpdateObserver.alert.calcelButton"];
}

- (NSInteger) versionNumberFromString:(NSString *)versionString{
    return [[versionString stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
}

- (NSString *)localizedStringWithFormat:(NSString *)format {
    return NSLocalizedString(format, nil);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSURL *updateUrl = [NSURL URLWithString:versionInfo[@"update_url"]];
    if (updateUrl) {
        [[UIApplication sharedApplication] openURL:updateUrl];
    }
}

@end
