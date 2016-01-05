//
//  DRYNavigationDescriptorTests.m
//  DRYNavigationManager
//
//  Created by Jens Goeman on 24/11/15.
//  Copyright (c) 2015 AppFoundry. All rights reserved.
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
@import XCTest;

#import <DRYNavigationManager/DRYNavigationDescriptor.h>
#import "DRYNavigator.h"

@interface DummyClass : NSObject<DRYNavigator>

@end

@interface DRYNavigationDescriptorTests : XCTestCase


@end

@implementation DRYNavigationDescriptorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCreatingADescriptor {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey"}];
    assertThat(descriptor,is(notNilValue()));
}

- (void)testCreatingADescriptorConvencience {
    DRYNavigationDescriptor *descriptor = [DRYNavigationDescriptor descriptorWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey"}];
    assertThat(descriptor,is(notNilValue()));
}

- (void)testAddingParameterToDescriptorWithoutParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:nil];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    assertThat(valueAdded, is(equalTo(valueToAdd)));
}

- (void)testAddingParameterToDescriptorWithEmptyParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{}];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    assertThat(valueAdded, is(equalTo(valueToAdd)));
}

- (void)testAddingParameterToDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey"}];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    assertThat(valueAdded, is(equalTo(valueToAdd)));
}

- (void)testAddingMutlipleParametersToDescriptor {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey"}];
    NSString *valueToAddOne = @"ADDED_VALUE_PARAMETER_ONE";
    NSString *keyToAddOne = @"ADDED_KEY_PARAMETER_ONE";
    NSString *valueToAddTwo = @"ADDED_VALUE_PARAMETER_TWO";
    NSString *keyToAddTwo = @"ADDED_KEY_PARAMETER_TWO";
    [descriptor addParameters:@{keyToAddOne : valueToAddOne, keyToAddTwo : valueToAddTwo}];
    NSString *valueAddedOne = descriptor.parameters[keyToAddOne];
    NSString *valueAddedTwo = descriptor.parameters[keyToAddTwo];
    assertThat(valueAddedOne, is(equalTo(valueToAddOne)));
    assertThat(valueAddedTwo, is(equalTo(valueToAddTwo)));
}

-(void)testRemovingParameterFromDescriptorWithEmptyParametes {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{}];
    NSString *keyToRemove = @"REMOVED_KEY_PARAMETER_ONE";
    [descriptor removeParameterForKey:keyToRemove];
    assertThatInteger(descriptor.parameters.allKeys.count, is(equalToInteger(0)));
}

-(void)testRemovingParameterFromDescriptorWithoutParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:nil];
    NSString *keyToRemove = @"REMOVED_KEY_PARAMETER_ONE";
    [descriptor removeParameterForKey:keyToRemove];
    assertThatInteger(descriptor.parameters.allKeys.count, is(equalToInteger(0)));
}

-(void)testRemovingParameterFromDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey", @"testKey2" : @"valueKey2"}];
    NSString *keyToRemove = @"testKey2";
    [descriptor removeParameterForKey:keyToRemove];
    assertThatInteger(descriptor.parameters.allKeys.count, is(equalToInteger(1)));
    assertThat(descriptor.parameters[keyToRemove], is(nilValue()));
}

-(void)testRemovingParametersFromDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:@{@"testKey" : @"valueKey", @"testKey2" : @"valueKey2"}];
    NSString *keyToRemove2 = @"testKey2";
    NSString *keyToRemove = @"testKey";
    [descriptor removeParameters:@[keyToRemove,keyToRemove2]];
    assertThatInteger(descriptor.parameters.allKeys.count, is(equalToInteger(0)));
}

-(void)testParametersDictionaryIsCopy {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:@"testValue" forKey:@"testKey"];
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:NSClassFromString(@"DummyClass") parameters:parameters];

    assertThat(parameters,isNot(sameInstance(descriptor.parameters))); //Not equal as in !=
}

- (void)testInitializerDoesNotFailOnNilClass {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithNavigatorClass:nil parameters:nil];
    assertThat(descriptor,is(notNilValue()));
}

- (void)testDefaultInitializerFails {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] init];
    assertThat(descriptor,is(nilValue()));
}



@end

@implementation DummyClass

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
}

@end
