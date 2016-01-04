//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYNavigationManager.h>
#import "AppConfiguration.h"
#import "AppNavigationHelper.h"
#import "AppIpadNavigationHelper.h"
#import "DefaultNavigationTranslationDataSource.h"
#import "DemoNavigationClassFactory.h"
#import "TabBarControllerNavigationClass.h"

@implementation AppConfiguration

- (DRYBaseNavigationManager *)createSingletonNavigationManager {
	id<DRYNavigationTranslationDataSource> translationDataSource = [[DefaultNavigationTranslationDataSource alloc] init];
	DemoNavigationClassFactory *navigationClassFactory = [[DemoNavigationClassFactory alloc] init];
	[navigationClassFactory registerNavigationClass:[self _tabBarNavigationClass]];
	return [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:translationDataSource navigationClassFactory:navigationClassFactory];

//    id<DRYNavigationHelper> helper;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        helper = [[AppIpadNavigationHelper alloc] init];
//    } else {
//        helper = [[AppNavigationHelper alloc] init];
//    }
//    return [[DRYBaseNavigationManager alloc] initWithNavigationHelper:helper];
}

- (id<DRYNavigationClass>)_tabBarNavigationClass {
	return [[TabBarControllerNavigationClass alloc] initWithTabCount:5];
}


@end