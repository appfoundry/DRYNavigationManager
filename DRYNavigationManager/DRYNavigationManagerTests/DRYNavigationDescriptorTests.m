//
//  DRYNavigationDescriptorTests.m
//  DRYNavigationManager
//
//  Created by Jens Goeman on 24/11/15.
//  Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRYNavigationDescriptor.h"

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
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey"}];
    XCTAssertNotNil(descriptor);
}

- (void)testCreatingADescriptorConvencience {
    DRYNavigationDescriptor *descriptor = [DRYNavigationDescriptor descriptorWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey"}];
    XCTAssertNotNil(descriptor);
}

- (void)testAddingParameterToDescriptorWithoutParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:nil];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    XCTAssertEqualObjects(valueAdded, valueToAdd);
}

- (void)testAddingParameterToDescriptorWithEmptyParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{}];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    XCTAssertEqualObjects(valueAdded, valueToAdd);
}

- (void)testAddingParameterToDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey"}];
    NSString *valueToAdd = @"ADDED_VALUE_PARAMETER";
    NSString *keyToAdd = @"ADDED_KEY_PARAMETER";
    [descriptor addParameter:valueToAdd forKey:keyToAdd];
    NSString *valueAdded = descriptor.parameters[keyToAdd];
    XCTAssertEqualObjects(valueAdded, valueToAdd);
}

- (void)testAddingMutlipleParametersToDescriptor {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey"}];
    NSString *valueToAddOne = @"ADDED_VALUE_PARAMETER_ONE";
    NSString *keyToAddOne = @"ADDED_KEY_PARAMETER_ONE";
    NSString *valueToAddTwo = @"ADDED_VALUE_PARAMETER_TWO";
    NSString *keyToAddTwo = @"ADDED_KEY_PARAMETER_TWO";
    [descriptor addParameters:@{keyToAddOne : valueToAddOne, keyToAddTwo : valueToAddTwo}];
    NSString *valueAddedOne = descriptor.parameters[keyToAddOne];
    NSString *valueAddedTwo = descriptor.parameters[keyToAddTwo];
    XCTAssertEqualObjects(valueAddedOne, valueToAddOne);
    XCTAssertEqualObjects(valueAddedTwo, valueToAddTwo);
}

-(void)testRemovingParameterFromDescriptorWithEmptyParametes {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{}];
    NSString *keyToRemove = @"REMOVED_KEY_PARAMETER_ONE";
    [descriptor removeParameterForKey:keyToRemove];
    XCTAssertTrue(descriptor.parameters.allKeys.count == 0);
}

-(void)testRemovingParameterFromDescriptorWithoutParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:nil];
    NSString *keyToRemove = @"REMOVED_KEY_PARAMETER_ONE";
    [descriptor removeParameterForKey:keyToRemove];
    XCTAssertEqual(descriptor.parameters.allKeys.count, 0);
}

-(void)testRemovingParameterFromDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey",@"testKey2":@"valueKey2"}];
    NSString *keyToRemove = @"testKey2";
    [descriptor removeParameterForKey:keyToRemove];
    XCTAssertEqual(descriptor.parameters.allKeys.count, 1);
    XCTAssertNil(descriptor.parameters[keyToRemove]);
}

-(void)testRemovingParametersFromDescriptorWithParameters {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:@{@"testKey":@"valueKey",@"testKey2":@"valueKey2"}];
    NSString *keyToRemove2 = @"testKey2";
    NSString *keyToRemove = @"testKey";
    [descriptor removeParameters:@[keyToRemove,keyToRemove2]];
    XCTAssertEqual(descriptor.parameters.allKeys.count, 0);
}

-(void)testParametersDictionaryIsCopy {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:@"testValue" forKey:@"testKey"];
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:@"DummyClassName" parameters:parameters];

    XCTAssertNotEqual(parameters, descriptor.parameters); //Not equal as in !=
}

- (void)testInitializerFailsOnNilClass {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] initWithClassName:nil parameters:nil];
    XCTAssertNil(descriptor);
}

- (void)testDefaultInitializerFails {
    DRYNavigationDescriptor *descriptor = [[DRYNavigationDescriptor alloc] init];
    XCTAssertNil(descriptor);
}



@end
