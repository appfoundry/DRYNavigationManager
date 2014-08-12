//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    _label = label;
    [self.view addSubview:_label];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (IBAction)didTapView:(UIView *)view {
    //Implemented by specific class
}


@end