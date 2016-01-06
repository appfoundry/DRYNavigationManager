//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DRYNavigationManagerError) {
    DRYNavigationManagerErrorNavigatorCreation = 201,
    DRYNavigationManagerErrorNavigatorImplementation = 202,

    DRYNavigationManagerErrorGenericNoAccess = 301,

    DRYNavigationManagerErrorGenericNavigate = 401,
};

@interface NSError (DRYNavigationManager)

+ (NSError *)dryNavigationDescriptorMissingNavigatorError;

+ (NSError *)dryNavigatorCreationError;

+ (NSError *)dryNavigatorImplementationError;

+ (NSError *)dryNoAccessToNavigationPathError;

+ (NSError *)dryCanNotNavigateError;

- (BOOL)isDRYNavigationManagerErrorWithType:(DRYNavigationManagerError)error;

@end