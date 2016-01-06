//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYNavigationManager.h>
#import "AppConfiguration.h"
#import "AppNavigationHelper.h"
#import "AppIpadNavigationHelper.h"
#import "DefaultNavigationTranslationDataSource.h"
#import "DemoNavigatorFactory.h"
#import "TabBarControllerNavigator.h"

@implementation AppConfiguration

- (DRYBaseNavigationManager *)createSingletonNavigationManager {
	id<DRYNavigationTranslationDataSource> translationDataSource = [[DefaultNavigationTranslationDataSource alloc] init];
	DemoNavigatorFactory *navigatorFactory = [[DemoNavigatorFactory alloc] init];
	return [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:translationDataSource navigatorFactory:navigatorFactory];

//    id<DRYNavigationHelper> helper;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        helper = [[AppIpadNavigationHelper alloc] init];
//    } else {
//        helper = [[AppNavigationHelper alloc] init];
//    }
//    return [[DRYBaseNavigationManager alloc] initWithNavigationHelper:helper];
}

@end