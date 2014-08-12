//
//  ModalViewController.m
//  DRYNavigationManagerDemo
//
//  Created by Michael Seghers on 12/08/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "ModalViewController.h"
#import <DRYNavigationManager/DRYNavigationManager.h>
#import "UIViewController+Reliant.h"

@interface ModalViewController ()

@property (nonatomic, weak) id<DRYNavigationManager> navigationManager;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injectSelf];
    self.label.text = @"Tap to close!";
}

- (void)didTapView:(UIView *)view {
    [_navigationManager unwindViewController:self];
}

@end
