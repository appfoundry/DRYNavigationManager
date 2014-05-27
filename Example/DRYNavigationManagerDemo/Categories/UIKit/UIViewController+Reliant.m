//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "UIViewController+Reliant.h"

#import "AppDelegate.h"

@implementation UIViewController (Reliant)

- (void)injectSelf {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate performInjectionOn:self];
}

@end