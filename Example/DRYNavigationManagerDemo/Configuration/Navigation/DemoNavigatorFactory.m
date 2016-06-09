//
// Created by Joris Dubois on 18/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DemoNavigatorFactory.h"
#import "HelloViewControllerNavigator.h"
#import "TabBarControllerNavigator.h"

@interface DemoNavigatorFactory () {
	NSMutableDictionary *_navigatorRegister;
    
}
@end

@implementation DemoNavigatorFactory

- (instancetype)init {
	self = [super init];
	if(self) {
		_navigatorRegister = [[NSMutableDictionary alloc] init];
        _navigatorRegister[NSStringFromClass(TabBarControllerNavigator.class)] = [self _tabBarNavigator];
	}
	return self;
}
                                 
- (id<DRYNavigator>)_tabBarNavigator {
    return [[TabBarControllerNavigator alloc] initWithTabCount:5];
}

- (id<DRYNavigator>)navigatorForClass:(Class)className {
    return _navigatorRegister[NSStringFromClass(className)] ?: [[className alloc] init];
}

- (id<DRYViewControllerInitializer>)viewControllerInitializerForClass:(Class)className {
    return [[className alloc] init];
}

@end