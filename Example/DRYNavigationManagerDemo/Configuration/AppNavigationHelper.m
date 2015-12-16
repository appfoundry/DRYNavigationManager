////
//// Created by Michael Seghers on 24/05/14.
//// Copyright (c) 2014 AppFoundry. All rights reserved.
////
//
//#import "AppNavigationHelper.h"
//#import "MainViewController.h"
//#import "InTabViewController.h"
//#import "ModalViewController.h"
//
//
//@implementation AppNavigationHelper
//
//- (UIViewController *)rootViewControllerForFlow:(id)flowIdentifier {
//    MainViewController *mainViewController = [[MainViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
//    return navigationController;
//}
//
//- (void)toDetailFrom:(UIViewController *) master withUserInfo:(NSDictionary *) userInfo {
//    HelloViewController *helloViewController = [[HelloViewController alloc] init];
//    helloViewController.text = userInfo[@"selectedName"];
//
//    [master.navigationController pushViewController:helloViewController animated:YES];
//}
//
//- (void)toTabFrom:(UIViewController *)helloVC withUserInfo:(NSDictionary *) userInfo {
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//
//    InTabViewController *one = [[InTabViewController alloc] init];
//    one.title = @"one";
//    InTabViewController *two = [[InTabViewController alloc] init];
//    two.title = @"two";
//    InTabViewController *three = [[InTabViewController alloc] init];
//    three.title = @"three";
//
//    tabBarController.viewControllers = @[one, two, three];
//
//    [helloVC.navigationController pushViewController:tabBarController animated:YES];
//}
//
//- (void)toModalFrom:(UIViewController *)presentingViewController withUserInfo:(NSDictionary *) userInfo {
//    ModalViewController *modalViewController = [[ModalViewController alloc] init];
//
//    [presentingViewController presentViewController:modalViewController animated:YES completion:nil];
//}
//
//- (void)didDismissModalViewController:(UIViewController *)viewController toPresenter:(UIViewController *)presenter {
//    NSLog(@"Auto dismiss!");
//}
//
//
//
//@end