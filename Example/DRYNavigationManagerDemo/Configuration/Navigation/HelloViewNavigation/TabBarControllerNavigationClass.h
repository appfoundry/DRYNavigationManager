//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRYNavigationClass.h"

@interface TabBarControllerNavigationClass : NSObject<DRYNavigationClass>

- (instancetype)initWithTabCount:(NSUInteger)tabCount;

@end