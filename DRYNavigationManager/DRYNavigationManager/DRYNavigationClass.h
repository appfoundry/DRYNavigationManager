//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol DRYNavigationClass <NSObject>

- (void)hasAccessWithParameters:(NSDictionary *)parameters completionHandler:(void (^)(BOOL hasAccess, NSError *error))completionHandler;

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController completionHandler:(void (^)(BOOL success, NSError *error))completionHandler;

@end