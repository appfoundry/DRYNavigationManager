//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import <Reliant/Reliant.h>
#import "TabBarControllerNavigator.h"
#import "InTabViewController.h"

@interface TabBarControllerNavigator () {
	NSUInteger _tabCount;
}
@end

@implementation TabBarControllerNavigator

- (instancetype)initWithTabCount:(NSUInteger)tabCount {
	self = [super init];
	if (self) {
		_tabCount = tabCount;
	}
	return self;
}

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
	NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
	for (int i = 0; i < _tabCount; ++i) {
		InTabViewController *tabViewController = [[InTabViewController alloc] init];
        [tabViewController ocsInject];
		tabViewController.title = @(i+1).stringValue;
		tabViewControllers[(NSUInteger) i] = tabViewController;
	}
	tabBarController.viewControllers = tabViewControllers;
    [hostViewController.navigationController pushViewController:tabBarController animated:YES];
}

@end