//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYNavigationManager.h>
#import "AppConfiguration.h"
#import "DRYDefaultDataSource.h"
#import "DemoNavigatorFactory.h"
#import "NavigationConstants.h"

#import "MainFlowViewControllerInitializer.h"

#import "HelloViewControllerNavigator.h"
#import "TabBarControllerNavigator.h"
#import "ModalViewControllerNavigator.h"
#import "CloseModalViewControllerNavigator.h"

@implementation AppConfiguration

- (id <DRYNavigationManager>)createSingletonNavigationManager {
    NSDictionary<NSString *, Class> *navigatorClassRegistry = @{
                                                                TO_HELLO_VIEW_IDENTIFIER : HelloViewControllerNavigator.class,
                                                                TO_TAB_BAR_VIEW_CONTROLLER : TabBarControllerNavigator.class,
                                                                TO_MODAL_VIEW_CONTROLLER : ModalViewControllerNavigator.class,
                                                                CLOSE_MODAL_VIEW_CONTROLLER : CloseModalViewControllerNavigator.class
                                                                };
    NSDictionary<NSString *, Class> *viewControllerInitializerClassRegistry = @{
                                                                                MAIN_FLOW_IDENTIFIER : MainFlowViewControllerInitializer.class
                                                                                };
    id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource> translationDataSource = [[DRYDefaultDataSource alloc] initWithNavigatorClassRegistry:navigatorClassRegistry viewControllerInitializerClassRegistry:viewControllerInitializerClassRegistry];
    id<DRYNavigatorFactory, DRYViewControllerInitializerFactory> navigatorFactory = [[DemoNavigatorFactory alloc] init];
    
    return [[DRYBaseNavigationManager alloc] initWithCommonTranslationDataSource:translationDataSource commonFactory:navigatorFactory];
}

@end