//
// Created by Joris Dubois on 18/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DemoNavigationClassFactory.h"
#import "HelloViewControllerNavigationClass.h"

@interface DemoNavigationClassFactory() {
	NSMutableDictionary *_navigationClassRegister;
}
@end

@implementation DemoNavigationClassFactory

- (instancetype)init {
	self = [super init];
	if(self) {
		_navigationClassRegister = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)registerNavigationClass:(id<DRYNavigationClass>)navigationClass {
	_navigationClassRegister[navigationClass.class] = navigationClass;
}

- (id<DRYNavigationClass>)navigationClassForClass:(Class)className {
	return _navigationClassRegister[className];
}

@end