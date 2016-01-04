//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DefaultNavigationTranslationDataSource.h"
#import "NavigationConstants.h"
#import "HelloViewControllerNavigationClass.h"
#import "TabBarControllerNavigationClass.h"
#import "ModalViewControllerNavigationClass.h"
#import "CloseModalViewControllerNavigationClass.h"

@implementation DefaultNavigationTranslationDataSource {
	NSDictionary<NSString *, Class> *_navigationTranslationDataSource;
}

- (instancetype)init {
	self = [super init];
	if(self) {
		_navigationTranslationDataSource = @{
				TO_HELLO_VIEW_IDENTIFIER : HelloViewControllerNavigationClass.class,
				TO_TAB_BAR_VIEW_CONTROLLER : TabBarControllerNavigationClass.class,
				TO_MODAL_VIEW_CONTROLLER : ModalViewControllerNavigationClass.class,
				CLOSE_MODAL_VIEW_CONTROLLER : CloseModalViewControllerNavigationClass.class
		};
	}
	return self;
}

- (Class)classNameForNavigationIdentifier:(NSString *)navigationIdentifier {
	return _navigationTranslationDataSource[navigationIdentifier];
}

@end