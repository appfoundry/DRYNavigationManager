//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "HelloViewControllerNavigationClass.h"
#import "HelloViewController.h"

@implementation HelloViewControllerNavigationClass

- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	successHandler();
}

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	HelloViewController *helloViewController = [[HelloViewController alloc] init];
	helloViewController.text = parameters[@"selectedName"];
	[hostViewController.navigationController pushViewController:helloViewController animated:YES];
}

@end