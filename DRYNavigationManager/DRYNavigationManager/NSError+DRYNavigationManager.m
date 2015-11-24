//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "NSError+DRYNavigationManager.h"

NSString *const kDRYNavigationManagerErrorDomain = @"be.appfoundry.errorDomain.DRYNavigationManager";

@implementation NSError (DRYNavigationManager)

#pragma mark - Utils for checking errors

- (BOOL)isDRYNavigationManagerErrorWithType:(DRYNavigationManagerError)error {
    return [self.domain isEqualToString:kDRYNavigationManagerErrorDomain] && self.code == error;
}

#pragma mark - Utils for creating errors

+ (NSError *)dataSourceUnavailableError {
    return [NSError errorWithLocalizedDescription:@"DRYNavigationTranslationDataSource can't be messaged"
                                  localizedReason:@"DRYNavigationTranslationDataSource is nil or method being called isn't implemented"
                                        errorType:DRYNavigationManagerErrorDataSourcesUnavailable
                                         userInfo:nil];
}

+ (NSError *)navigationClassCreationError {
    return [NSError errorWithLocalizedDescription:@"Your navigation class can't be created"
                                  localizedReason:@"Can't find the class to create an instance from or initialization has failed"
                                        errorType:DRYNavigationManagerErrorNavigationClassCreation
                                         userInfo:nil];
}

+ (NSError *)navigationClassImplementationError {
    return [NSError errorWithLocalizedDescription:@"Your navigation class implemenation is not correct"
                                  localizedReason:@"Your navigation class should implemented the DRYNavgiationClassProtocol"
                                        errorType:DRYNavigationManagerErrorNavigationClassImplementation
                                         userInfo:nil];
}

+ (NSError *)noAccessToNavigationPathError {
    return [NSError errorWithLocalizedDescription:@"No Access"
                                  localizedReason:@"Your navigation class did not specify a specific error as to why you don't have access"
                                        errorType:DRYNavigationManagerErrorGenericNoAccess
                                         userInfo:nil];
}

+ (NSError *)canNotNavigateError {
    return [NSError errorWithLocalizedDescription:@"Can not navigate"
                                  localizedReason:@"Your navigation class did not specify a specific error as to why you can't navigate"
                                        errorType:DRYNavigationManagerErrorGenericNavigate
                                         userInfo:nil];
}

#pragma mark - Private helpers

+ (NSError *)errorWithLocalizedDescription:(NSString *)description localizedReason:(NSString *)reason errorType:(DRYNavigationManagerError)error userInfo:(NSDictionary *)userInfo {
    NSMutableDictionary *userInfoToSend = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (userInfo) {
        userInfoToSend = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    }
    [userInfoToSend addEntriesFromDictionary:@{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : reason}];

    return [[NSError alloc] initWithDomain:kDRYNavigationManagerErrorDomain code:error userInfo:userInfoToSend];
}

@end