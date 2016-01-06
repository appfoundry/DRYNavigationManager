//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationManager.h"
#import "DRYNavigationTranslationDataSource.h"
#import "DRYNavigationDescriptor.h"
#import "NSError+DRYNavigationManager.h"
#import "DRYNavigatorFactory.h"
#import "DRYDefaultNavigatorFactory.h"
#import "DRYSecureNavigator.h"

@interface DRYBaseNavigationManager () {
	id <DRYNavigationTranslationDataSource> _navigationTranslationDataSource;
}

@property(nonatomic, strong, readonly) id <DRYNavigatorFactory> navigatorFactory;

@end

@implementation DRYBaseNavigationManager

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource {
    return [self initWithNavigationTranslationDataSource:navigationTranslationDataSource navigatorFactory:[[DRYDefaultNavigatorFactory alloc] init]];
}

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource navigatorFactory:(id<DRYNavigatorFactory>)navigatorFactory {
	if (!navigatorFactory || !navigationTranslationDataSource) {
        return nil;
    }

    self = [super init];
	if (self) {
		_navigationTranslationDataSource = navigationTranslationDataSource;
		_navigatorFactory = navigatorFactory;
	}
	return self;
}

- (DRYNavigationDescriptor *)_createNavigationDescriptorWithNavigationIdentifier:(NSString *)navigationIdentifier parameters:(NSDictionary *)parameters error:(NSError **)error {
    Class navigatorClass = [_navigationTranslationDataSource classNameForNavigationIdentifier:navigationIdentifier ];
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

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    NSError *error;
    DRYNavigationDescriptor *descriptor = [self _createNavigationDescriptorWithNavigationIdentifier:identifier parameters:parameters error:&error];
    if (error) {
        [self _callErrorHandlerBlock:errorHandler error:error];
    } else {
        [self _navigateWithNavigationDescriptor:descriptor hostViewController:hostViewController errorHandler:errorHandler successHandler:successHandler];
    }
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