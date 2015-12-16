//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DefaultNavigationTranslationDataSource.h"
#import "NavigationConstants.h"
#import "HelloViewControllerNavigationClass.h"

@implementation DefaultNavigationTranslationDataSource {
	NSDictionary<NSString *, Class> *_navigationTranslationDataSource;
}

- (instancetype)init {
	self = [super init];
	if(self) {
		_navigationTranslationDataSource = @{
				TO_HELLO_VIEW_IDENTIFIER : HelloViewControllerNavigationClass.class
		};
	}
	return self;
}

- (NSString *)classNameForNavigationIdentifier:(NSString *)navigationIdentifier {
	return NSStringFromClass(_navigationTranslationDataSource[navigationIdentifier]);
}

@end