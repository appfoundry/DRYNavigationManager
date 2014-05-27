//
//  AppDelegate.m
//  navigation-manager-poc
//
//  Created by Michael Seghers on 23/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Reliant/OCSApplicationContext.h>
#import <Reliant/OCSConfiguratorFromClass.h>
#import <DRYNavigationManager/DRYNavigationManager.h>

#import "AppDelegate.h"
#import "AppConfiguration.h"

@interface AppDelegate () {
    OCSApplicationContext *_context;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id <OCSConfigurator> configurator = [[OCSConfiguratorFromClass alloc] initWithClass:[AppConfiguration class]];
    _context = [[OCSApplicationContext alloc] initWithConfigurator:configurator];
    [_context start];

    id <DRYNavigationManager> navigationManager = [_context objectForKey:@"navigationManager"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [navigationManager rootViewControllerForFlow:@"main"];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)performInjectionOn:(id)object {
    [_context performInjectionOn:object];
}

@end