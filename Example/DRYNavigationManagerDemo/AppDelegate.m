//
//  AppDelegate.m
//  navigation-manager-poc
//
//  Created by Michael Seghers on 23/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Reliant/Reliant.h>
#import "DRYBaseNavigationManager.h"
#import "AppDelegate.h"
#import "AppConfiguration.h"
#import "MainViewController.h"

@interface AppDelegate () {
    OCSObjectContext *_context;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id <OCSConfigurator> configurator = [[OCSConfiguratorFromClass alloc] initWithClass:[AppConfiguration class]];
    _context = [[OCSObjectContext alloc] initWithConfigurator:configurator];
    [_context start];

	MainViewController *mainViewController = [[MainViewController alloc] init];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)performInjectionOn:(id)object {
    [_context performInjectionOn:object];
}

@end