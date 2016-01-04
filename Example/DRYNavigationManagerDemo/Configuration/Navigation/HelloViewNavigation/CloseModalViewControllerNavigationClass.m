//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import "CloseModalViewControllerNavigationClass.h"

@implementation CloseModalViewControllerNavigationClass

- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	if(arc4random_uniform(100) < 50) {
		successHandler();
	} else {
		errorHandler([NSError errorWithDomain:@"be.appfoundry.DRYNavigationManagerDemo" code:0 userInfo:@{@"accessMessage" : @"Bad luck, you are denied. try again!"}]);
	}
}

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	[hostViewController dismissViewControllerAnimated:YES completion:nil];
}

@end