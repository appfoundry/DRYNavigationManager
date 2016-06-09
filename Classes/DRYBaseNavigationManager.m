//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationManager.h"
#import "DRYNavigationTranslationDataSource.h"
#import "DRYFlowTranslationDataSource.h"
#import "DRYNavigationDescriptor.h"
#import "NSError+DRYNavigationManager.h"
#import "DRYNavigatorFactory.h"
#import "DRYDefaultNavigatorFactory.h"
#import "DRYSecureNavigator.h"

@interface DRYBaseNavigationManager ()

@property(nonatomic, strong, readonly) id <DRYNavigationTranslationDataSource> navigationTranslationDataSource;
@property(nonatomic, strong, readonly) id <DRYFlowTranslationDataSource> flowTranslationDataSource;

@property(nonatomic, strong, readonly) id <DRYNavigatorFactory> navigatorFactory;
@property(nonatomic, strong, readonly) id <DRYViewControllerInitializerFactory> viewControllerInitializerFactory;

@end

@implementation DRYBaseNavigationManager

- (instancetype)initWithNavigationTranslationDataSource:(id<DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id<DRYFlowTranslationDataSource>)flowTranslationDataSource {
    return [self initWithNavigationTranslationDataSource:navigationTranslationDataSource flowTranslationDataSource:flowTranslationDataSource commonFactory:[[DRYDefaultNavigatorFactory alloc] init]];
}

- (instancetype)initWithNavigationTranslationDataSource:(id<DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id<DRYFlowTranslationDataSource>)flowTranslationDataSource viewControllerInitializerFactory:(id<DRYViewControllerInitializerFactory>)viewControllerInitializerFactory {
    return [self initWithNavigationTranslationDataSource:navigationTranslationDataSource flowTranslationDataSource:flowTranslationDataSource navigatorFactory:[[DRYDefaultNavigatorFactory alloc] init] viewControllerInitializerFactory:viewControllerInitializerFactory];
}

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource navigatorFactory:(id <DRYNavigatorFactory>)navigatorFactory {
    return [self initWithNavigationTranslationDataSource:navigationTranslationDataSource flowTranslationDataSource:flowTranslationDataSource navigatorFactory:navigatorFactory viewControllerInitializerFactory:[[DRYDefaultNavigatorFactory alloc] init]];
}

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource {
    return [self initWithNavigationTranslationDataSource:commonDataSource flowTranslationDataSource:commonDataSource];
}

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource viewControllerInitializerFactory:(id<DRYViewControllerInitializerFactory>)viewControllerInitializerFactory {
    return [self initWithNavigationTranslationDataSource:commonDataSource flowTranslationDataSource:commonDataSource viewControllerInitializerFactory:viewControllerInitializerFactory];
}

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory {
    return [self initWithNavigationTranslationDataSource:commonDataSource flowTranslationDataSource:commonDataSource navigatorFactory:navigatorFactory];
}

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory viewControllerInitializerFactory:(id<DRYViewControllerInitializerFactory>)viewControllerInitializerFactory {
    return [self initWithNavigationTranslationDataSource:commonDataSource flowTranslationDataSource:commonDataSource navigatorFactory:navigatorFactory viewControllerInitializerFactory:viewControllerInitializerFactory];
}

- (instancetype)initWithCommonTranslationDataSource:(id<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>)commonDataSource commonFactory:(id<DRYNavigatorFactory, DRYViewControllerInitializerFactory>)commonFactory {
    return [self initWithNavigationTranslationDataSource:commonDataSource flowTranslationDataSource:commonDataSource navigatorFactory:commonFactory viewControllerInitializerFactory:commonFactory];
}
- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource flowTranslationDataSource:(id <DRYFlowTranslationDataSource>)flowTranslationDataSource commonFactory:(id<DRYNavigatorFactory, DRYViewControllerInitializerFactory>)commonFactory {
    return [self initWithNavigationTranslationDataSource:navigationTranslationDataSource flowTranslationDataSource:flowTranslationDataSource navigatorFactory:commonFactory viewControllerInitializerFactory:commonFactory];
}

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource  flowTranslationDataSource:(id<DRYFlowTranslationDataSource>)flowTranslationDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory viewControllerInitializerFactory:(id<DRYViewControllerInitializerFactory>)viewControllerInitializerFactory {
	if (!navigatorFactory || !navigationTranslationDataSource || !viewControllerInitializerFactory || !flowTranslationDataSource) {
        return nil;
    }

    self = [super init];
	if (self) {
		_navigationTranslationDataSource = navigationTranslationDataSource;
        _flowTranslationDataSource = flowTranslationDataSource;
        _navigatorFactory = navigatorFactory;
        _viewControllerInitializerFactory = viewControllerInitializerFactory;
	}
	return self;
}

- (UIViewController *)initialViewControllerForFlowWithIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
    UIViewController *result = nil;
    Class viewControllerInitializerClass = [self.flowTranslationDataSource classNameForFlowIdentifier:identifier];
    if ([self _fillError:error onNilValue:viewControllerInitializerClass withError:^NSError *{return [NSError dryFlowNotFoundError];}]) {
        id <DRYViewControllerInitializer> viewControllerInitializer = [self.viewControllerInitializerFactory viewControllerInitializerForClass:viewControllerInitializerClass];
        if ([self _fillError:error onNilValue:viewControllerInitializer withError:^NSError *{ return [NSError dryViewControlllerInitializerCreationError];}]) {
            result = [viewControllerInitializer viewControllerWithParameters:parameters error:error];
        }
    }
    return result;
}

- (BOOL)_fillError:(NSError *__autoreleasing *)receiver onNilValue:(id)valueOrNil withError:(NSError *(^)())error {
    BOOL result = YES;
    if (!valueOrNil) {
        if (receiver) {
            *receiver = error();
        }
        result = NO;
    }
    return result;
}


- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    NSError *error;
    DRYNavigationDescriptor *descriptor = [self _createNavigationDescriptorWithNavigationIdentifier:identifier parameters:parameters error:&error];
    if (error) {
        [self _callErrorHandlerBlock:errorHandler error:error];
    } else {
        [self _navigateWithNavigationDescriptor:descriptor hostViewController:hostViewController errorHandler:errorHandler successHandler:successHandler];
    }
}

- (DRYNavigationDescriptor *)_createNavigationDescriptorWithNavigationIdentifier:(NSString *)navigationIdentifier parameters:(NSDictionary *)parameters error:(NSError **)error {
    Class navigatorClass = [self.navigationTranslationDataSource classNameForNavigationIdentifier:navigationIdentifier ];
    return [DRYNavigationDescriptor descriptorWithNavigatorClass:navigatorClass parameters:parameters];
}

- (void)_navigateWithNavigationDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController errorHandler:(void (^)(NSError *error))errorHandler successHandler:(void (^)())successHandler {
    if(!descriptor.navigatorClass){
        [self _callErrorHandlerBlock:errorHandler error:[NSError dryNavigationDescriptorMissingNavigatorError]];
        return;
    }
    id <DRYNavigator> navigator = [_navigatorFactory navigatorForClass:descriptor.navigatorClass];
    if (!navigator) {
        [self _callErrorHandlerBlock:errorHandler error:[NSError dryNavigatorCreationError]];
        return;
    }
    
    if (![navigator conformsToProtocol:@protocol(DRYNavigator)] || ![navigator respondsToSelector:@selector(navigateWithParameters:hostViewController:errorHandler:successHandler:)]) {
        [self _callErrorHandlerBlock:errorHandler error:[NSError dryNavigatorImplementationError]];
        return;
    }
    
    [self _navigateWhenAllowedWithDescriptor:descriptor hostViewController:hostViewController navigator:navigator errorHandler:errorHandler successHandler:successHandler];
}

#pragma mark - Private Helpers

- (void)_callErrorHandlerBlock:(DRYNavigationErrorHandler)errorHandler error:(NSError *)error {
    if (errorHandler) {
        errorHandler(error);
    }
}
- (void)_callSuccessHandlerBlock:(DRYNavigationSuccessHandler)successHandler {
    if (successHandler) {
        successHandler();
    }
}

- (void)_navigateWhenAllowedWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigator:(id <DRYNavigator>)navigator errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
	if([navigator conformsToProtocol:@protocol(DRYSecureNavigator)] && [navigator respondsToSelector:@selector(hasAccessWithParameters:errorHandler:successHandler:)]){
		[((id<DRYSecureNavigator>) navigator) hasAccessWithParameters:descriptor.parameters errorHandler:^(NSError *error) {
			[self _callErrorHandlerBlock:errorHandler error:error?: [NSError dryNoAccessToNavigationPathError]];
		}                                              successHandler:^{
            [self _navigateWithDescriptor:descriptor hostViewController:hostViewController navigator:navigator errorHandler:errorHandler succesHandler:successHandler];
		}];
	} else {
        [self _navigateWithDescriptor:descriptor hostViewController:hostViewController navigator:navigator errorHandler:errorHandler succesHandler:successHandler];
	}
}

- (void)_navigateWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigator:(id <DRYNavigator>)navigator errorHandler:(DRYNavigationErrorHandler)errorHandler succesHandler:(DRYNavigationSuccessHandler)succesHandler {
    [navigator navigateWithParameters:descriptor.parameters
                   hostViewController:hostViewController
                         errorHandler:^(NSError *error) {
                             [self _callErrorHandlerBlock:errorHandler error:[NSError dryCanNotNavigateError]];
                         }
                       successHandler:^{
                           [self _callSuccessHandlerBlock:succesHandler];
                       }];
}

@end