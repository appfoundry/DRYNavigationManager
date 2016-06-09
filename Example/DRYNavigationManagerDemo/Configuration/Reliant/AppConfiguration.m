//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYNavigationManager.h>
#import "AppConfiguration.h"
#import "DefaultNavigationTranslationDataSource.h"
#import "DemoNavigatorFactory.h"

@implementation AppConfiguration

- (id <DRYNavigationManager>)createSingletonNavigationManager {
	id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource> translationDataSource = [[DefaultNavigationTranslationDataSource alloc] init];
	id<DRYNavigatorFactory, DRYViewControllerInitializerFactory> navigatorFactory = [[DemoNavigatorFactory alloc] init];
	return [[DRYBaseNavigationManager alloc] initWithCommonTranslationDataSource:translationDataSource commonFactory:navigatorFactory];
}

@end