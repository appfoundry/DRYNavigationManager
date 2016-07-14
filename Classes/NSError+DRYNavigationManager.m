//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "NSError+DRYNavigationManager.h"

NSString *const kDRYNavigationManagerErrorDomain = @"be.appfoundry.errorDomain.DRYBaseNavigationManager";

@implementation NSError (DRYNavigationManager)

#pragma mark - Utils for checking errors

- (BOOL)isDRYNavigationManagerErrorWithType:(DRYNavigationManagerError)error {
    return [self.domain isEqualToString:kDRYNavigationManagerErrorDomain] && self.code == error;
}

#pragma mark - Utils for creating errors

+ (NSError *)dryNavigationDescriptorMissingNavigatorError {
    return [self _dryNavigatorCreationErrorWithDescription:@"Your navigation descriptor is missing a navigator class"];
}

+ (NSError *)dryNavigatorCreationError {
    return [self _dryNavigatorCreationErrorWithDescription:@"Your navigation class can't be created"];
}

+ (NSError *)_dryNavigatorCreationErrorWithDescription:(NSString *)description {
    return [NSError _dryErrorWithLocalizedDescription:description
                                      localizedReason:@"Can't find the class to create an instance from or initialization has failed"
                                            errorType:DRYNavigationManagerErrorNavigatorCreation
                                             userInfo:nil];
}

+ (NSError *)dryNavigatorImplementationError {
    return [NSError _dryErrorWithLocalizedDescription:@"Your navigation class implemenation is not correct"
                                      localizedReason:@"Your navigation class should implemented the DRYNavgiationClassProtocol"
                                            errorType:DRYNavigationManagerErrorNavigatorImplementation
                                             userInfo:nil];
}

+ (NSError *)dryNoAccessToNavigationPathError {
    return [NSError _dryErrorWithLocalizedDescription:@"No Access"
                                      localizedReason:@"Your navigation class did not specify a specific error as to why you don't have access"
                                            errorType:DRYNavigationManagerErrorGenericNoAccess
                                             userInfo:nil];
}

+ (NSError *)dryCanNotNavigateError {
    return [NSError _dryErrorWithLocalizedDescription:@"Can not navigate"
                                      localizedReason:@"Your navigation class did not specify a specific error as to why you can't navigate"
                                            errorType:DRYNavigationManagerErrorGenericNavigate
                                             userInfo:nil];
}


+ (NSError *)dryViewControlllerInitializerCreationError {
    return [NSError _dryErrorWithLocalizedDescription:@"Can not find view controller initializer"
                                      localizedReason:@"Your view controller initializer factor could notfind a proper view controller initializer"
                                            errorType:DRYNavigationManagerErrorViewControllerInitializerCreation
                                             userInfo:nil];
}

+ (NSError *)dryFlowNotFoundError {
    return [NSError _dryErrorWithLocalizedDescription:@"Can not initialize flow"
                                      localizedReason:@"Your flow data source could not find a proper view controller initializer"
                                            errorType:DRYNavigationManagerErrorFlowNotFound
                                             userInfo:nil];
}


#pragma mark - Private helpers

+ (NSError *)_dryErrorWithLocalizedDescription:(NSString *)description localizedReason:(NSString *)reason errorType:(DRYNavigationManagerError)error userInfo:(NSDictionary *)userInfo {
    NSMutableDictionary *userInfoToSend = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (userInfo) {
        userInfoToSend = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    }
    [userInfoToSend addEntriesFromDictionary:@{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : reason}];

    return [[NSError alloc] initWithDomain:kDRYNavigationManagerErrorDomain code:error userInfo:userInfoToSend];
}

@end