//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationDescriptor.h"

@interface DRYNavigationDescriptor ()

@property(nonatomic, strong, readwrite) NSString *className;

@property(nonatomic, strong, readwrite) NSDictionary *parameters;

@end

@implementation DRYNavigationDescriptor

#pragma mark - Initialisation

- (instancetype)initWithClassName:(NSString *)className parameters:(NSDictionary *)parameters {
    self = [super init];
    if (self) {
        _className = className;
        _parameters = parameters;
    }

    return self;
}

+ (instancetype)descriptorWithClassName:(NSString *)className parameters:(NSDictionary *)parameters {
    return [[self alloc] initWithClassName:className parameters:parameters];
}

#pragma mark - Utils For adding en removing parameters

- (void)addParameter:(id)value forKey:(NSString *)key {
    [self addParameters:@{key : value}];
}

- (void)removeParameterForKey:(NSString *)key {
    [self removeParameters:@[key]];
}

- (void)addParameters:(NSDictionary *)parametersToAdd {
    NSMutableDictionary *concatenatedDictionary = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
    [concatenatedDictionary addEntriesFromDictionary:parametersToAdd];
    self.parameters = concatenatedDictionary;
}

- (void)removeParameters:(NSArray *)parametersKeysToRemove {
    NSMutableDictionary *trimmedDictionary = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
    [trimmedDictionary removeObjectsForKeys:parametersKeysToRemove];
    self.parameters = trimmedDictionary;
}

@end