//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Reliant/Reliant.h>
#import "HelloViewControllerNavigator.h"
#import "HelloViewController.h"

@implementation HelloViewControllerNavigator

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	HelloViewController *helloViewController = [[HelloViewController alloc] init];
    [helloViewController ocsInject];
	helloViewController.text = parameters[@"selectedName"];
	[hostViewController.navigationController pushViewController:helloViewController animated:YES];
}

@end