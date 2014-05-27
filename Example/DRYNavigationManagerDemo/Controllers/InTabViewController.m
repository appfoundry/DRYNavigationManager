//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "InTabViewController.h"


@implementation InTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.label.text = [NSString stringWithFormat:@"Tab %i", [self.tabBarController.viewControllers indexOfObject:self] + 1];

}

@end