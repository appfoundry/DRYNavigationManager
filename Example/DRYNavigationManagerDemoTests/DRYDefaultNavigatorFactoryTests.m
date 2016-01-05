//
//  DRYDefaultNavigatorFactoryTests.m
//  DRYNavigationManagerDemo
//
//  Created by Jens Goeman on 05/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
@import XCTest;

#import "DRYNavigatorFactory.h"
#import "DRYDefaultNavigatorFactory.h"

@interface FooClass : NSObject <DRYNavigator>

@property (nonatomic) BOOL initCalled;

@end


@interface DRYDefaultNavigatorFactoryTests : XCTestCase

@property(nonatomic, strong) DRYDefaultNavigatorFactory *factory;

@end

@implementation DRYDefaultNavigatorFactoryTests

- (void)setUp {
    [super setUp];
    _factory = [[DRYDefaultNavigatorFactory alloc] init];
}

-(void)testCallsInitialisation {
    FooClass *createdInstance = [_factory navigatorForClass:[FooClass class]];
    assertThatBool(createdInstance.initCalled, isTrue());

}

@end

@implementation FooClass

- (instancetype)init {
    self = [super init];
    if (self) {
        _initCalled = YES;
    }

    return self;
}

@end
