//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//


@interface BaseViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *label;

- (IBAction)didTapView:(UIView *) view;

@end