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
    DRYNavigationSuccessHandler successHandlerNotNil;
    DRYNavigationErrorHandler errorHandlerNotNil;
    [self _createNonNilHandlers:errorHandler successHandler:successHandler successHandlerNotNil:&successHandlerNotNil errorHandlerNotNil:&errorHandlerNotNil];

    id <DRYNavigationClass> navigationClass = (id <DRYNavigationClass>) [[NSClassFromString(descriptor.className) alloc] init];
    if (!navigationClass) {
        errorHandlerNotNil([NSError navigationClassCreationError]);
        return;
    }
    if (![navigationClass conformsToProtocol:@protocol(DRYNavigationClass)]) {
        errorHandlerNotNil([NSError navigationClassImplementationError]);
        return;
    }

    [self _checkAccessAndNavigateWhenAllowedWithDescriptor:descriptor hostViewController:hostViewController navigationClass:navigationClass errorHandler:errorHandlerNotNil successHandler:successHandlerNotNil];
}

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    DRYNavigationSuccessHandler successHandlerNotNil;
    DRYNavigationErrorHandler errorHandlerNotNil;
    [self _createNonNilHandlers:errorHandler successHandler:successHandler successHandlerNotNil:&successHandlerNotNil errorHandlerNotNil:&errorHandlerNotNil];

    NSError *error;
    DRYNavigationDescriptor *descriptor = [self createNavigationDescriptorWithNavigationIdentifier:identifier parameters:parameters error:&error];
    if (error) {
        errorHandlerNotNil(error);
    } else {
        [self navigateWithNavigationDescriptor:descriptor hostViewController:hostViewController errorHandler:errorHandlerNotNil successHandler:successHandlerNotNil];
    }
}

#pragma mark - Private Helpers

- (void)_createNonNilHandlers:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler successHandlerNotNil:(DRYNavigationSuccessHandler *)successHandlerNotNil errorHandlerNotNil:(DRYNavigationErrorHandler *)errorHandlerNotNil {
    (*successHandlerNotNil) = ^void() {
        if (successHandler) {
            successHandler();
        }
    };
    (*errorHandlerNotNil) = ^void(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    };
}

- (void)_checkAccessAndNavigateWhenAllowedWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigationClass:(id <DRYNavigationClass>)navigationClass errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    [navigationClass hasAccessWithParameters:descriptor.parameters errorHandler:^(NSError *error) {
        errorHandler(error?:[NSError noAccessToNavigationPathError]);
    } successHandler:^{
        [self _navigateWithDescriptor:descriptor hostViewController:hostViewController navigationClass:navigationClass errorHandler:errorHandler succesHandler:successHandler];
    }];
}

- (void)_navigateWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController navigationClass:(id <DRYNavigationClass>)navigationClass errorHandler:(DRYNavigationErrorHandler)errorHandler succesHandler:(DRYNavigationSuccessHandler)succesHandler {
    [navigationClass navigateWithParameters:descriptor.parameters
                         hostViewController:hostViewController
                               errorHandler:^(NSError *error) {
                                   errorHandler(error ? : [NSError canNotNavigateError]);
                               }
                             successHandler:^{
                                 succesHandler();
                             }];
}

@end