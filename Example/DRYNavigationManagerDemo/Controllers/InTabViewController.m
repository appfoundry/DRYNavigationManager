//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "InTabViewController.h"
#import "DRYBaseNavigationManager.h"
#import "UIViewController+Reliant.h"
#import "NavigationConstants.h"

@interface InTabViewController ()

@property (nonatomic, weak) DRYBaseNavigationManager *navigationManager;

@end

@implementation InTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injectSelf];
     self.label.text = [NSString stringWithFormat:@"Tab %u", [self.tabBarController.viewControllers indexOfObject:self] + 1];

}

- (void)didTapView:(UIView *)view {
	[_navigationManager navigateWithNavigationIdentifier:TO_MODAL_VIEW_CONTROLLER parameters:nil hostViewController:self errorHandler:nil successHandler:nil];
}

@end