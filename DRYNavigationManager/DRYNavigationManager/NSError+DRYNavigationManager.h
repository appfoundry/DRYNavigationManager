//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DRYNavigationManagerError) {
    DRYNavigationManagerErrorDataSourcesUnavailable = 101,
    DRYNavigationManagerErrorDataSourcesImplementation = 102,

    DRYNavigationManagerErrorNavigationClassCreation = 201,
    DRYNavigationManagerErrorNavigationClassImplementation = 202,

    DRYNavigationManagerErrorGenericNoAccess = 301,

    DRYNavigationManagerErrorGenericNavigate = 401,
};

@interface NSError (DRYNavigationManager)

+ (NSError *)dataSourceUnavailableError;

+ (NSError *)dataSourceImplementationError;

+ (NSError *)navigationClassCreationError;

+ (NSError *)navigationClassImplementationError;

+ (NSError *)noAccessToNavigationPathError;

+ (NSError *)canNotNavigateError;

- (BOOL)isDRYNavigationManagerErrorWithType:(DRYNavigationManagerError)error;

@end