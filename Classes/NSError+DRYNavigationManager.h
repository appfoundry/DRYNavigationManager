//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DRYNavigationManagerError) {
    DRYNavigationManagerErrorDataSourcesUnavailable = 101,
    DRYNavigationManagerErrorDataSourcesImplementation = 102,

    DRYNavigationManagerErrorNavigatorCreation = 201,
    DRYNavigationManagerErrorNavigatorImplementation = 202,

    DRYNavigationManagerErrorGenericNoAccess = 301,

    DRYNavigationManagerErrorGenericNavigate = 401,
};

@interface NSError (DRYNavigationManager)

+ (NSError *)dryDataSourceUnavailableError;

+ (NSError *)dryDataSourceImplementationError;

+ (NSError *)dryNavigationDescriptorMissingNavigatorError;

+ (NSError *)dryNavigatorCreationError;

+ (NSError *)dryNavigatorImplementationError;

+ (NSError *)dryNoAccessToNavigationPathError;

+ (NSError *)dryCanNotNavigateError;

- (BOOL)isDRYNavigationManagerErrorWithType:(DRYNavigationManagerError)error;

@end