//
//  DRYBaseNavigationManagerTests.m
//  DRYNavigationManagerDemo
//
//  Created by Jens Goeman on 05/01/16.
//  Copyright (c) 2016 AppFoundry. All rights reserved.
//

#import "DRYNavigationManagerTests.h"
#import "DRYNavigationManager.h"
#import "DRYDefaultNavigatorFactory.h"
#import "NSError+DRYNavigationManager.h"

@interface DRYBaseNavigationManager (TestKnowsAll)

@property(nonatomic, strong, readonly) id <DRYNavigationTranslationDataSource> navigationTranslationDataSource;
@property(nonatomic, strong, readonly) id <DRYFlowTranslationDataSource> flowTranslationDataSource;

@property(nonatomic, strong, readonly) id <DRYNavigatorFactory> navigatorFactory;
@property(nonatomic, strong, readonly) id <DRYViewControllerInitializerFactory> viewControllerInitializerFactory;

@end

@interface DummyNavigator : NSObject <DRYNavigator>

@property(nonatomic, strong) UIViewController *hostViewController;
@property(nonatomic, strong) NSDictionary *parameters;

@end

@interface DummyViewControllerInitializer : NSObject <DRYViewControllerInitializer>
@end

@interface NonDummyNavigator : NSObject
@end

@interface UnaccessableNavigator : NSObject <DRYSecureNavigator>
@end

@interface AccessableFailingNavigator : NSObject <DRYSecureNavigator>
@end


@interface DRYBaseNavigationManagerTests : XCTestCase {
    DRYBaseNavigationManager *_manager;
    id <DRYNavigationTranslationDataSource> _dataSource;
    id <DRYFlowTranslationDataSource> _flowDataSource;
    id <DRYNavigatorFactory> _navigatorFactory;
    id <DRYViewControllerInitializerFactory> _viewControllerInitializerFactory;
}

@end

@implementation DRYBaseNavigationManagerTests

- (void)setUp {
    [super setUp];
    _dataSource = mockProtocol(@protocol(DRYNavigationTranslationDataSource));
    _flowDataSource = mockProtocol(@protocol(DRYFlowTranslationDataSource));
    _navigatorFactory = mockProtocol(@protocol(DRYNavigatorFactory));
    _viewControllerInitializerFactory = mockProtocol(@protocol(DRYViewControllerInitializerFactory));
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:_flowDataSource navigatorFactory:_navigatorFactory viewControllerInitializerFactory:_viewControllerInitializerFactory];
}

- (void)testConvenienceInitUsesDefaultNavigatorFactoryAsNavigatorFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:_flowDataSource];
    assertThat(_manager.navigatorFactory, is(instanceOf(DRYDefaultNavigatorFactory.class)));
}

- (void)testConvenienceInitUsesDefaultNavigatorFactoryAsViewControllerInitializerFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:_flowDataSource];
    assertThat(_manager.viewControllerInitializerFactory, is(instanceOf(DRYDefaultNavigatorFactory.class)));
}

- (void)testInitShouldReturnNilOnNilNavigatorDataSource {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:nil flowTranslationDataSource:_flowDataSource];
    assertThat(_manager, is(nilValue()));
}

- (void)testInitShouldReturnNilOnNilFlowDataSource {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:nil];
    assertThat(_manager, is(nilValue()));
}


- (void)testInitShouldReturnNilOnNilNavigatorFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:_flowDataSource navigatorFactory:nil];
    assertThat(_manager, is(nilValue()));
}

- (void)testInitShouldReturnNilOnNilViewControllerFactory {
    _manager = [[DRYBaseNavigationManager alloc] initWithNavigationTranslationDataSource:_dataSource flowTranslationDataSource:_flowDataSource navigatorFactory:_navigatorFactory viewControllerInitializerFactory:nil];
    assertThat(_manager, is(nilValue()));
}

- (void)testInitialViewControllerIsTakenFromViewInitializerFactory {
    NSError *error;
    id <DRYViewControllerInitializer> initializer =  [self _givenViewControllerInitializerClass:[DummyViewControllerInitializer class]];
    NSDictionary *params = @{};
    UIViewController *viewController = mock([UIViewController class]);
    [[given([initializer viewControllerWithParameters:sameInstance(params) error:&error]) withMatcher:anything() forArgument:1] willReturn:viewController];
    UIViewController *result = [_manager initialViewControllerForFlowWithIdentifier:@"flowId" parameters:params error:&error];
    assertThat(result, sameInstance(viewController));
}

- (void)testInitialViewControllerReportsErrorWhenFlowNotFound {
    NSError *error;
    [_manager initialViewControllerForFlowWithIdentifier:@"flowId" parameters:nil error:&error];
    assertThatInteger(error.code, is(equalToInteger(DRYNavigationManagerErrorFlowNotFound)));
}

- (void)testInitialViewControllerReportsErrorWhenInitializerNotCreated {
    NSError *error;
    [given([_flowDataSource classNameForFlowIdentifier:@"flowId"]) willReturn:[DummyViewControllerInitializer class]];
    [_manager initialViewControllerForFlowWithIdentifier:@"flowId" parameters:nil error:&error];
    assertThatInteger(error.code, is(equalToInteger(DRYNavigationManagerErrorViewControllerInitializerCreation)));
}

- (void)testInitialViewControllerIsNilWhenFlowNotFound {
    assertThat([_manager initialViewControllerForFlowWithIdentifier:@"flowId" parameters:nil error:nil], is(nilValue()));
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

- (id<DRYViewControllerInitializer>)_givenViewControllerInitializerClass:(Class)initializerClass {
    [given([_flowDataSource classNameForFlowIdentifier:@"flowId"]) willReturn:initializerClass];
    id result = mock(initializerClass);
    [given([_viewControllerInitializerFactory viewControllerInitializerForClass:initializerClass]) willReturn:result];
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

@implementation DummyViewControllerInitializer

- (UIViewController *)viewControllerWithParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
    return nil;
}

@end

@implementation NonDummyNavigator

@end


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