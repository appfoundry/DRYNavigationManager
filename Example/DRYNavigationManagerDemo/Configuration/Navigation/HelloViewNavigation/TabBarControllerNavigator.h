//
// Created by Joris Dubois on 04/01/16.
// Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRYNavigator.h"

@interface TabBarControllerNavigator : NSObject<DRYNavigator>

- (instancetype)initWithTabCount:(NSUInteger)tabCount;

@end