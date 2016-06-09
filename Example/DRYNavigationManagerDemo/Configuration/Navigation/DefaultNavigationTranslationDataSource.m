//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DefaultNavigationTranslationDataSource.h"
#import "NavigationConstants.h"
#import "HelloViewControllerNavigator.h"
#import "TabBarControllerNavigator.h"
#import "ModalViewControllerNavigator.h"
#import "CloseModalViewControllerNavigator.h"
#import "LoginFlowViewControllerInitializer.h"
#import "MainFlowViewControllerInitializer.h"

@implementation DefaultNavigationTranslationDataSource {
	NSDictionary<NSString *, Class> *_navigationTranslationDataSource;
    NSDictionary<NSString *, Class> *_flowTranslationDataSource;
}

- (instancetype)init {
	self = [super init];
	if(self) {
		_navigationTranslationDataSource = @{
				TO_HELLO_VIEW_IDENTIFIER : HelloViewControllerNavigator.class,
				TO_TAB_BAR_VIEW_CONTROLLER : TabBarControllerNavigator.class,
				TO_MODAL_VIEW_CONTROLLER : ModalViewControllerNavigator.class,
				CLOSE_MODAL_VIEW_CONTROLLER : CloseModalViewControllerNavigator.class
		};
        _flowTranslationDataSource = @{
                LOGIN_FLOW_IDENTIFIER : LoginFlowViewControllerInitializer.class,
                MAIN_FLOW_IDENTIFIER : MainFlowViewControllerInitializer.class
        };
	}
	return self;
}

- (Class)classNameForNavigationIdentifier:(NSString *)navigationIdentifier {
	return _navigationTranslationDataSource[navigationIdentifier];
}

- (Class)classNameForFlowIdentifier:(NSString *)flowIdentifier {
    return _flowTranslationDataSource[flowIdentifier];
}

@end