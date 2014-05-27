//
//  MainViewController.h
//  navigation-manager-poc
//
//  Created by Michael Seghers on 24/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//



#import "HelloViewController.h"

@interface MainViewController : UITableViewController

@property (nonatomic, weak) id<HelloSayer> helloSayer; //only used in case of iPad

@end
