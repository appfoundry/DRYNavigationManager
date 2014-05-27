//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRYNavigationHelper <NSObject>

- (UIViewController *) rootViewControllerForFlow:(NSString *) flowIdentifier;

@end