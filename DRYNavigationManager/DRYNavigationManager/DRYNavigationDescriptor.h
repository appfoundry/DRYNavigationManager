//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;

@protocol DRYNavigationClass;

@interface DRYNavigationDescriptor : NSObject

@property(nonatomic, strong, readonly) Class navigationClass;

@property(nonatomic, copy, readonly) NSDictionary *parameters;

- (instancetype)initWithNavigationClass:(Class)className parameters:(NSDictionary *)parameters;

+ (instancetype)descriptorWithNavigationClass:(Class)className parameters:(NSDictionary *)parameters;

- (void)addParameter:(id)value forKey:(NSString *)key;

- (void)removeParameterForKey:(NSString *)key;

- (void)addParameters:(NSDictionary *)parametersToAdd;

- (void)removeParameters:(NSArray *)parametersKeysToRemove;

@end