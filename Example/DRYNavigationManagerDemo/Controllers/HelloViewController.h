//
// Created by Michael Seghers on 24/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "HelloSayer.h"


@interface HelloViewController : BaseViewController <UISplitViewControllerDelegate, HelloSayer>

@property (nonatomic, strong) NSString *text;

@end