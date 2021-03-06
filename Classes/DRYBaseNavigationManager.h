//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "DRYNavigator.h"

@protocol DRYNavigationTranslationDataSource;
@class DRYNavigationDescriptor;

@protocol DRYNavigatorFactory;

@interface DRYBaseNavigationManager : NSObject

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource;

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource navigatorFactory:(id <DRYNavigatorFactory>)navigatorFactory;

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

@end