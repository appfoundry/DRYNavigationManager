//
// Created by Joris Dubois on 18/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DRYNavigationManager/DRYNavigationManager.h>

@interface DemoNavigationClassFactory : NSObject<DRYNavigationClassFactory>

- (void)registerNavigationClass:(id <DRYNavigationClass>)navigationClass;

@end