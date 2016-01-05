//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import "ModalViewControllerNavigator.h"
#import "ModalViewController.h"

@implementation ModalViewControllerNavigator

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	ModalViewController *modalViewController = [[ModalViewController alloc] init];
    [hostViewController presentViewController:modalViewController animated:YES completion:nil];
}

@end