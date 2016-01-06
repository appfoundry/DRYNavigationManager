//
//  DRYDefaultNavigatorFactoryTests.m
//  DRYNavigationManagerDemo
//
//  Created by Jens Goeman on 05/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

#import "DRYNavigationManagerTests.h"
#import "DRYNavigatorFactory.h"
#import "DRYDefaultNavigatorFactory.h"

@interface FooClass : NSObject <DRYNavigator>

@property (nonatomic) BOOL initCalled;

@end


@interface DRYDefaultNavigatorFactoryTests : XCTestCase {
    DRYDefaultNavigatorFactory *_factory;
}
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
