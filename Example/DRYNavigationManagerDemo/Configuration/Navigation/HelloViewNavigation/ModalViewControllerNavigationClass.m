//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import "ModalViewControllerNavigationClass.h"
#import "ModalViewController.h"

@implementation ModalViewControllerNavigationClass

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	ModalViewController *modalViewController = [[ModalViewController alloc] init];
    [hostViewController presentViewController:modalViewController animated:YES completion:nil];
}

@end