//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationManager.h"
#import "DRYNavigationTranslationDataSource.h"
#import "DRYNavigationDescriptor.h"
#import "NSError+DRYNavigationManager.h"
#import "DRYNavigationClassProtocol.h"

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
    if ([translationDataSource respondsToSelector:@selector(classNameForNavigationIdentifier:)]) {
        className = [translationDataSource classNameForNavigationIdentifier:navigationIdentifier];
        descriptor = [DRYNavigationDescriptor descriptorWithClassName:className parameters:parameters];
    } else {
        *error = [NSError dataSourceUnavailableError];
    }
    return descriptor;
}

- (void)navigateWithNavigationDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController completionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    id <DRYNavigationClassProtocol> navigationClass = (id <DRYNavigationClassProtocol>) [[NSClassFromString(descriptor.className) alloc] init];
    if (!navigationClass) {
        completionHandler(NO, [NSError navigationClassCreationError]);
        return;
    }
    if (![navigationClass conformsToProtocol:@protocol(DRYNavigationClassProtocol)]) {
        completionHandler(NO, [NSError navigationClassImplementationError]);
        return;
    }

    [self _checkAccessAndNavigateWhenAllowedWithDescriptor:descriptor hostViewController:hostViewController completionHandler:completionHandler navigationClass:navigationClass];
}

- (void)navigateWithNavigationIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController completionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSError *error;
    DRYNavigationDescriptor *descriptor = [self createNavigationDescriptorWithNavigationIdentifier:identifier parameters:parameters error:&error];
    if (error) {
        completionHandler(NO, error);
    } else {
        [self navigateWithNavigationDescriptor:descriptor hostViewController:hostViewController completionHandler:^(BOOL success, NSError *error) {
            completionHandler(success, error);
        }];
    }
}

- (void)_checkAccessAndNavigateWhenAllowedWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController completionHandler:(void (^)(BOOL, NSError *))completionHandler navigationClass:(id <DRYNavigationClassProtocol>)navigationClass {
    [navigationClass hasAccessWithParameters:descriptor.parameters completionHandler:^(BOOL hasAccess, NSError *error) {
        if (!hasAccess) {
            if (error) {
                completionHandler(NO, error);
            } else {
                completionHandler(NO, [NSError noAccessToNavigationPathError]);
            }
        } else {
            [self _navigateWithDescriptor:descriptor hostViewController:hostViewController completionHandler:completionHandler navigationClass:navigationClass];
        }
    }];
}

- (void)_navigateWithDescriptor:(DRYNavigationDescriptor *)descriptor hostViewController:(UIViewController *)hostViewController completionHandler:(void (^)(BOOL, NSError *))completionHandler navigationClass:(id <DRYNavigationClassProtocol>)navigationClass {
    [navigationClass navigateWithParameters:descriptor.parameters hostViewController:hostViewController completionHandler:^(BOOL success, NSError *error) {
        if (!success) {
            if (error) {
                completionHandler(NO, error);
            } else {
                completionHandler(NO, [NSError canNotNavigateError]);
            }
        } else {
            completionHandler(YES, nil);
        }
    }];
}

@end