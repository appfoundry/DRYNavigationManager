//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "DRYNavigationClass.h"

@protocol DRYNavigationTranslationDataSource;
@class DRYNavigationDescriptor;

@protocol DRYNavigationClassFactory;

@interface DRYBaseNavigationManager : NSObject

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource navigationClassFactory:(id <DRYNavigationClassFactory>)navigationClassFactory;

- (DRYNavigationDescriptor *)createNavigationDescriptorWithNavigationIdentifier:(NSString *)navigationIdentifier parameters:(NSDictionary *)parameters error:(NSError **)error;

- (void)navigateWithNavigationDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

@end