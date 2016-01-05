//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;

@protocol DRYNavigator;

@interface DRYNavigationDescriptor : NSObject

@property(nonatomic, strong, readonly) Class navigatorClass;

@property(nonatomic, copy, readonly) NSDictionary *parameters;

- (instancetype)initWithNavigatorClass:(Class)navigatorClass parameters:(NSDictionary *)parameters;

+ (instancetype)descriptorWithNavigatorClass:(Class)navigatorClass parameters:(NSDictionary *)parameters;

- (void)addParameter:(id)value forKey:(NSString *)key;

- (void)removeParameterForKey:(NSString *)key;

- (void)addParameters:(NSDictionary *)parametersToAdd;

- (void)removeParameters:(NSArray *)parametersKeysToRemove;

@end