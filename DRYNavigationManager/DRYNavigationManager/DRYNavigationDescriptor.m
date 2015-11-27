//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import "DRYNavigationDescriptor.h"

@interface DRYNavigationDescriptor () {
    NSMutableDictionary *_parameters;
}

@property(nonatomic, strong) NSString *className;

@end

@implementation DRYNavigationDescriptor

#pragma mark - Initialisation
@synthesize parameters = _parameters;

- (instancetype)init {
    return nil;
}

- (instancetype)initWithClassName:(NSString *)className parameters:(NSDictionary *)parameters {
    if (className) {
        self = [super init];
        if (self) {
            _className = className;
            _parameters = parameters ? [parameters mutableCopy] : [NSMutableDictionary dictionary];
        }
    } else {
        self = nil;
    }
    
    return self;
}

+ (instancetype)descriptorWithClassName:(NSString *)className parameters:(NSDictionary *)parameters {
    return [[self alloc] initWithClassName:className parameters:parameters];
}

#pragma mark - Utils For adding en removing parameters

- (void)addParameter:(id)value forKey:(NSString *)key {
    _parameters[key] = value;
}

- (void)removeParameterForKey:(NSString *)key {
    [self removeParameters:@[key]];
}

- (void)addParameters:(NSDictionary *)parametersToAdd {
    [_parameters addEntriesFromDictionary:parametersToAdd];
}

- (void)removeParameters:(NSArray *)parametersKeysToRemove {
    [_parameters removeObjectsForKeys:parametersKeysToRemove];
}

- (NSDictionary *)parameters {
    return [_parameters copy];
}

@end