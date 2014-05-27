//
//  AppIpadNavigationHelper.m
//  navigation-manager-bigbang
//
//  Created by Bart Vandeweerdt on 25/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "AppIpadNavigationHelper.h"
#import "MainViewController.h"
#import "HelloViewController.h"
#import "InTabViewController.h"

@implementation AppIpadNavigationHelper

- (UIViewController *)rootViewControllerForFlow:(id)flowIdentifier {
    MainViewController *mainViewController = [[MainViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];

    HelloViewController *helloViewController = [[HelloViewController alloc] init];
    helloViewController.text = @"iPad";
    UINavigationController *helloNavigationController = [[UINavigationController alloc] initWithRootViewController:helloViewController];
    
    mainViewController.helloSayer = helloViewController;

    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    splitViewController.viewControllers = @[mainNavigationController, helloNavigationController];
    
    splitViewController.delegate = helloViewController;
    
    return splitViewController;
}

- (void)toDetailFrom:(UIViewController *) master withUserInfo:(NSDictionary *) userInfo {
    //do nothing
}

- (void)toTabFrom:(UIViewController *)helloVC withUserInfo:(NSDictionary *) userInfo {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    InTabViewController *one = [[InTabViewController alloc] init];
    one.title = @"one";
    InTabViewController *two = [[InTabViewController alloc] init];
    two.title = @"two";
    InTabViewController *three = [[InTabViewController alloc] init];
    three.title = @"three";
    
    tabBarController.viewControllers = @[one, two, three];
    
    [helloVC.navigationController pushViewController:tabBarController animated:YES];
}


@end
