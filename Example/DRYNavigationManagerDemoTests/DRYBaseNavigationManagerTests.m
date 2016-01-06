//
//  DRYBaseNavigationManagerTests.m
//  DRYNavigationManagerDemo
//
//  Created by Jens Goeman on 05/01/16.
//  Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import "DRYNavigationManagerTests.h"
#import "DRYBaseNavigationManager.h"
#import "DRYDefaultNavigatorFactory.h"
#import "NSError+DRYNavigationManager.h"
#import "DRYNavigationTranslationDataSource.h"
#import "DRYSecureNavigator.h"

@interface DRYBaseNavigationManager (TestKnowsAll)

@property(nonatomic, strong, readonly) id <DRYNavigatorFactory> navigatorFactory;

@end

@interface DummyNavigator : NSObject <DRYNavigator>

@property(nonatomic, strong) UIViewController *hostViewController;
@property(nonatomic, strong) NSDictionary *parameters;

@end

@interface NonDummyNavigator : NSObject <DRYNavigator>
@end

@interface UnaccessableNavigator : NSObject <DRYSecureNavigator>
@end

@interface AccessableFailingNavigator : NSObject <DRYSecureNavigator>
@end


@interface DRYBaseNavigationManagerTests : XCTestCase {
    DRYBaseNavigationManager *_manager;
    id <DRYNavigationTranslationDataSource> _dataSource;
    id <DRYNavigatorFactory> _navigatorFactory;
}

@end

@implementation DRYBaseNavigationManagerTests

- (void)setUp {
    [super setUp];
    _dataSource = mockProtocol(@protocol(DRYNavigationTranslationDataSource));
    _navigatorFactory = mockProtocol(@protocol(DRYNavigatorFactory));
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource navigatorFactory:_navigatorFactory];
}

- (void)testConvenienceInitUsesDefaultNavigatorFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource];
    assertThat(_manager.navigatorFactory, is(instanceOf(DRYDefaultNavigatorFactory.class)));
}

- (void)testInitShouldReturnNilOnNilDataSource {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:nil navigatorFactory:_navigatorFactory];
    assertThat(_manager, is(nilValue()));
}

- (void)testInitShouldReturnNilOnNilNavigatorFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource navigatorFactory:nil];
    assertThat(_manager, is(nilValue()));
}


- (void)testReportsErrorWhenNavigatorNotFound {
    [self _expectErrorOfType:DRYNavigationManagerErrorNavigatorCreation identifier:@"id" parameters:nil];
}

- (void)testReportsErrorWhenNavigatorIsNotANavigatorClass {
    [self _givenNavigatorClass:[NSObject class]];
    [self _expectErrorOfType:DRYNavigationManagerErrorNavigatorImplementation identifier:@"id" parameters:nil];
}

- (void)testReportsErrorWhenNavigatorIsANavigatorClassButDoesNotHaveExpectedMethods {
    [self _givenNavigatorClass:[NonDummyNavigator class]];
    [self _expectErrorOfType:DRYNavigationManagerErrorNavigatorImplementation identifier:@"id" parameters:nil];
}

- (void)testReportsErrorWhenIdentifierIsNil {
    [self _givenNavigatorClass:[NSObject class]];
    [self _expectErrorOfType:DRYNavigationManagerErrorNavigatorCreation identifier:nil parameters:nil];
}

- (void)testReportsErrorWhenNotAccessable {
    [self _givenNavigatorClass:[UnaccessableNavigator class]];
    [self _expectErrorOfType:DRYNavigationManagerErrorGenericNoAccess identifier:@"id" parameters:nil];
}

- (void)testReportsErrorWhenNavigatorReportsError {
    [self _givenNavigatorClass:[AccessableFailingNavigator class]];
    [self _expectErrorOfType:DRYNavigationManagerErrorGenericNavigate identifier:@"id" parameters:nil];
}

- (void)testReportsSuccessWhenNavigationIsSuccesful {
    id <DRYNavigator> navigator = [self _givenNavigatorClass:[DummyNavigator class]];
    [self _expectSuccessForIdentifier:@"id" parameters:@{} controller:[[UIViewController alloc] init] onNavigator:navigator];
}

- (void)_expectErrorOfType:(enum DRYNavigationManagerError)expectedError identifier:(NSString *)identifier parameters:(NSDictionary *)parameters {
    XCTestExpectation *expectation = [super expectationWithDescription:@"ErrorExpectation"];
    [_manager navigateWithNavigationIdentifier:identifier parameters:parameters hostViewController:nil errorHandler:^(NSError *error) {
        assertThatInteger(error.code, is(equalToInteger(expectedError)));
        [expectation fulfill];
    } successHandler:^{
        XCTFail(@"Should not end with success");
    }];
    [super waitForExpectationsWithTimeout:0.1 handler:^(NSError *error) {}];
}

- (void)_expectSuccessForIdentifier:(NSString *)identifier parameters:(NSDictionary *)parameters controller:(UIViewController *)controller onNavigator:(DummyNavigator *)navigator {
    XCTestExpectation *expectation = [super expectationWithDescription:@"SuccesExpectation"];
    [_manager navigateWithNavigationIdentifier:identifier parameters:parameters hostViewController:controller errorHandler:^(NSError *error) {
        XCTFail(@"Should not end with error");
    } successHandler:^{
        assertThat(navigator, allOf(hasProperty(@"parameters", sameInstance(parameters)), hasProperty(@"hostViewController", sameInstance(controller)),nil));
        [expectation fulfill];
    }];
    [super waitForExpectationsWithTimeout:0.1 handler:^(NSError *error) {}];
}

- (id<DRYNavigator>)_givenNavigatorClass:(Class)navigatorClass {
    [given([_dataSource classNameForNavigationIdentifier:@"id"]) willReturn:navigatorClass];
    id result = [[navigatorClass alloc] init];
    [given([_navigatorFactory navigatorForClass:navigatorClass]) willReturn:result];
    return result;
}



@end



@implementation DummyNavigator
- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    self.hostViewController = hostViewController;
    self.parameters = parameters;
    successHandler();
}

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
//Ignore missing implementation, this is what we wanted to test!
@implementation NonDummyNavigator
@end
#pragma clang diagnostic pop


@implementation UnaccessableNavigator
- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    errorHandler(nil);
}

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
}

@end


@implementation AccessableFailingNavigator
- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    successHandler();
}

- (void)navigateWithParameters:(NSDictionary *)parameters hostViewController:(UIViewController *)hostViewController errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler {
    errorHandler(nil);
}

@end