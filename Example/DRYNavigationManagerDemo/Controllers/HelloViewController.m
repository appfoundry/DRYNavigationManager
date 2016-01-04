//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "DRYBaseNavigationManager.h"
#import "HelloViewController.h"
#import "UIViewController+Reliant.h"
#import "NavigationConstants.h"

@interface HelloViewController ()

@property (nonatomic, weak) DRYBaseNavigationManager *navigationManager;

@end

@implementation HelloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injectSelf];
    self.label.text = [NSString stringWithFormat:@"Howdy %@!", self.text];
    self.title = @"Hello";

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Tab" style:UIBarButtonItemStylePlain target:self action:@selector(goFurther:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)goFurther:(id)goFurther {
	[_navigationManager navigateWithNavigationIdentifier:TO_TAB_BAR_VIEW_CONTROLLER parameters:nil hostViewController:self errorHandler:nil successHandler:nil];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = [NSString stringWithFormat:@"Howdy %@!", self.text];
}

#pragma mark - (iPad only) UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc
{
    [barButtonItem setTitle:@"master"];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)splitViewController:(UISplitViewController*)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}

@end