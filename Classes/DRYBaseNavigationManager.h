//
// Created by Michael Seghers on 23/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DRYNavigationManager.h"

@protocol DRYNavigationHelper;


@interface DRYBaseNavigationManager : NSObject<DRYNavigationManager>

- (instancetype) initWithNavigationHelper:(NSObject<DRYNavigationHelper> *) navigationHelper;

@end