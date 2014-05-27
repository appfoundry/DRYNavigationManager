//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYBaseNavigationManager.h>

#import "AppConfiguration.h"
#import "AppNavigationHelper.h"
#import "AppIpadNavigationHelper.h"

@implementation AppConfiguration

- (id<DRYNavigationManager>)createSingletonNavigationManager {
    id<DRYNavigationHelper> helper;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        helper = [[AppIpadNavigationHelper alloc] init];
    } else {
        helper = [[AppNavigationHelper alloc] init];
    }
    return [[DRYBaseNavigationManager alloc] initWithNavigationHelper:helper];
}


@end