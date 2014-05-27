//
// Created by Michael Seghers on 23/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainViewController;

@protocol DRYNavigationManager <NSObject>

- (UIViewController *)rootViewControllerForFlow:(id)flowIdentifier;

- (void)navigateFromViewController:(UIViewController *)controller withIdentifier:(NSString *)identifier withUserInfo:(NSDictionary *)userInfo;

@end