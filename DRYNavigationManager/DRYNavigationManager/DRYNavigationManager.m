//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationManager.h"
#import "DRYNavigationTranslationDataSource.h"
#import "DRYNavigationDescriptor.h"
#import "NSError+DRYNavigationManager.h"

@interface DRYNavigationManager ()

@property(nonatomic, weak) id <DRYNavigationTranslationDataSource> navigationTranslationDataSource;

@end

@implementation DRYNavigationManager

- (instancetype)initWithNavigationTranslationDataSource:(id <DRYNavigationTranslationDataSource>)navigationTranslationDataSource {
    self = [super init];
    if (self) {
        _navigationTranslationDataSource = navigationTranslationDataSource;
    }
    
    return self;
}

- (DRYNavigationDescriptor *)createNavigationDescriptorWithNavigationIdentifier:(NSString *)navigationIdentifier parameters:(NSDictionary *)parameters error:(NSError **)error {
    DRYNavigationDescriptor *descriptor;
    NSString *className;
    id <DRYNavigationTranslationDataSource> translationDataSource = self.navigationTranslationDataSource;
    if(!self.navigationTranslationDataSource) {
        *error = [NSError dataSourceUnavailableError];
    } else if ([translationDataSource respondsToSelector:@selector(classNameForNavigationIdentifier:)]) {
        className = [translationDataSource classNameForNavigationIdentifier:navigationIdentifier];
        descriptor = [DRYNavigationDescriptor descriptorWithClassName:className parameters:parameters];
    } else {
        *error = [NSError dataSourceImplementationError];
    }
    return descriptor;
}

- (void)navigateWithNavigationDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController errorHandler:(void (^)(NSError *error))errorHandler successHandler:(void (^)())successHandler {
    id <DRYNavigationClass> navigationClass = (id <DRYNavigationClass>) [[NSClassFromString(descriptor.className) alloc] init];
    if (!navigationClass) {
        [self _callErrorHandlerBlock:errorHandler error:[NSError navigationClassCreationError]];
        return;
    }
    if (![navigationClass conformsToProtocol:@protocol(DRYNavigationClass)]) {
        [self _callErrorHandlerBlock:errorHandler error:[NSError navigationClassImplementationError]];
        return;
    }
    
    [self _checkAccessAndNavigateWhenAllowedWithDescriptor:descriptor hostViewController:hostViewController navigationClass:navigationClass errorHandler:errorHandler successHandler:successHandler];
}

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    NSError *error;
    DRYNavigationDescriptor *descriptor = [self createNavigationDescriptorWithNavigationIdentifier:identifier parameters:parameters error:&error];
    if (error) {
        [self _callErrorHandlerBlock:errorHandler error:error];
    } else {
        [self navigateWithNavigationDescriptor:descriptor hostViewController:hostViewController errorHandler:errorHandler successHandler:successHandler];
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

- (void)_checkAccessAndNavigateWhenAllowedWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigationClass:(id <DRYNavigationClass>)navigationClass errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    [navigationClass hasAccessWithParameters:descriptor.parameters errorHandler:^(NSError *error) {
        [self _callErrorHandlerBlock:errorHandler error:error?:[NSError noAccessToNavigationPathError]];
    } successHandler:^{
        [self _navigateWithDescriptor:descriptor hostViewController:hostViewController navigationClass:navigationClass errorHandler:errorHandler succesHandler:successHandler];
    }];
}

- (void)_navigateWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigationClass:(id <DRYNavigationClass>)navigationClass errorHandler:(DRYNavigationErrorHandler)errorHandler succesHandler:(DRYNavigationSuccessHandler)succesHandler {
    [navigationClass navigateWithParameters:descriptor.parameters
                         hostViewController:hostViewController
                               errorHandler:^(NSError *error) {
                                   [self _callErrorHandlerBlock:errorHandler error:[NSError canNotNavigateError]];
                               }
                             successHandler:^{
                                 [self _callSuccessHandlerBlock:succesHandler];
                             }];
}

@end