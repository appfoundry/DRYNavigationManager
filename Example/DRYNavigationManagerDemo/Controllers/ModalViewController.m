//
//  ModalViewController.m
//  DRYNavigationManagerDemo
//
//  Created by Michael Seghers on 12/08/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "ModalViewController.h"
#import "DRYBaseNavigationManager.h"
#import "UIViewController+Reliant.h"
#import "NavigationConstants.h"

@interface ModalViewController ()

@property (nonatomic, weak) DRYBaseNavigationManager *navigationManager;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injectSelf];
    self.label.text = @"Tap to close!";
}

- (void)didTapView:(UIView *)view {
    [_navigationManager navigateWithNavigationIdentifier:CLOSE_MODAL_VIEW_CONTROLLER parameters:nil hostViewController:self errorHandler:^(NSError *error) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.userInfo[@"accessMessage"] delegate:nil cancelButtonTitle:@"Alright" otherButtonTitles:nil];
		[alertView show];
	} successHandler:nil];
}

@end
