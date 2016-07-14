//
//  MainFlowViewControllerInitializer.m
//  DRYNavigationManagerDemo
//
//  Created by Michael Seghers on 09/06/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

#import <Reliant/Reliant.h>
#import "MainFlowViewControllerInitializer.h"
#import "MainViewController.h"

@implementation MainFlowViewControllerInitializer

- (UIViewController *)viewControllerWithParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
    MainViewController *controller = [[MainViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller ocsInject];
    return navController;
}

@end
