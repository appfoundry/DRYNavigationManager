//
//  DRYDefaultNavigatorFactoryTests.m
//  DRYNavigationManagerDemo
//
//  Created by Jens Goeman on 05/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

#import "DRYNavigationManagerTests.h"
#import "DRYNavigationManager.h"
#import "DRYDefaultNavigatorFactory.h"

@interface FooClass : NSObject

@property (nonatomic) BOOL initCalled;

@end

@interface FooNavigatorClass : FooClass <DRYNavigator>

@end

@interface FooViewControllerInitializeClass : FooClass <DRYViewControllerInitializer>

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

-(void)testNavigatorForClassCallsInitialisation {
    FooNavigatorClass *createdInstance = [_factory navigatorForClass:[FooNavigatorClass class]];
    assertThatBool(createdInstance.initCalled, isTrue());

}

- (void)testViewControllerInitializerForClassCallsInitialisation {
    FooViewControllerInitializeClass *createdInstance = [_factory viewControllerInitializerForClass:[FooViewControllerInitializeClass class]];
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

@implementation FooNavigatorClass

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    
}

@end


@implementation FooViewControllerInitializeClass

- (UIViewController *)viewControllerWithParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
    return nil;
}

@end