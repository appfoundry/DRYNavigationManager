//
//  AppDelegate.m
//  navigation-manager-poc
//
//  Created by Michael Seghers on 23/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <Reliant/Reliant.h>
#import <DRYNavigationManager/DRYNavigationManager.h>
#import "AppDelegate.h"
#import "AppConfiguration.h"
#import "NavigationConstants.h"

@interface AppDelegate ()

@property (nonatomic, strong) id<DRYNavigationManager>navigationManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self ocsBootstrapAndBindObjectContextWithConfiguratorFromClass:[AppConfiguration class]];
    [self ocsInject];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self.navigationManager initialViewControllerForFlowWithIdentifier:MAIN_FLOW_IDENTIFIER parameters:nil error:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end