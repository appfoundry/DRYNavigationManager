//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DRYNavigator.h"

@protocol DRYNavigatorFactory;
@protocol DRYViewControllerInitializerFactory;
@protocol DRYFlowTranslationDataSource;
@protocol DRYNavigationTranslationDataSource;
@class DRYNavigationDescriptor;

@protocol DRYNavigationManager <NSObject>

- (UIViewController *)initialViewControllerForFlowWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters error:(NSError **)error;
- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

@end

@interface DRYBaseNavigationManager : NSObject <DRYNavigationManager>

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource viewControllerInitializerFactory:(id <DRYViewControllerInitializerFactory>)viewControllerInitializerFactory;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource navigatorFactory:(id <DRYNavigatorFactory>)navigatorFactory;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource navigatorFactory:(id <DRYNavigatorFactory>)navigatorFactory viewControllerInitializerFactory:(id <DRYViewControllerInitializerFactory>)viewControllerInitializerFactory;

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource;
- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource viewControllerInitializerFactory:(id <DRYViewControllerInitializerFactory>)viewControllerInitializerFactory;
- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory;
- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory viewControllerInitializerFactory:(id <DRYViewControllerInitializerFactory>)viewControllerInitializerFactory;
- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource commonFactory:(id<DRYNavigatorFactory, DRYViewControllerInitializerFactory>)commonFactory;
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource commonFactory:(id<DRYNavigatorFactory, DRYViewControllerInitializerFactory>)commonFactory;
@end