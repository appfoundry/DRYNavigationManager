////
////  DRYNavigationManagerDemoTests.m
////  DRYNavigationManagerDemoTests
////
////  Created by Michael Seghers on 27/05/14.
////  Copyright (c) 2014 AppFoundry. All rights reserved.
////
//
//#define HC_SHORTHAND
//#import <OCHamcrest/OCHamcrest.h>
//#import <XCTest/XCTest.h>
//#import <DRYNavigationManager/DRYBaseNavigationManager.h>
//#import <DRYNavigationManager/DRYNavigationHelper.h>
//
//
//@interface DRYNavigationManagerDemoTests : XCTestCase<DRYNavigationHelper>
//
//@end
//
//@implementation DRYNavigationManagerDemoTests{
//    UIViewController *recordedVC;
//    BOOL called;
//    DRYBaseNavigationManager *_mgr;
//    NSDictionary *recorededUserInfo;
//}
//
//- (void)setUp {
//    [super setUp];
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//    called = NO;
//    recordedVC = nil;
//    _mgr = [[DRYBaseNavigationManager alloc] initWithNavigationHelper:self];
//}
//
//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    [super tearDown];
//}
//
//- (void)testNavigateUsingKnownMethod {
//    UIViewController *vc = [[UIViewController alloc] init];
//    NSDictionary *userInfo = @{@"key": @"value"};
//    [_mgr navigateFromViewController:vc withIdentifier:@"toDetail" withUserInfo:userInfo];
//
//    assertThatBool(called, isTrue());
//    assertThat(recordedVC, is(equalTo(vc)));
//    assertThat(recorededUserInfo, is(equalTo(userInfo)));
//}
//
//- (void)testNavigateUsingUnknownMethod {
//    UIViewController *vc = [[UIViewController alloc] init];
//
//    XCTAssertNoThrow([_mgr navigateFromViewController:vc withIdentifier:@"toUnknown" withUserInfo:@{}]);
//}
//
//- (void)testRootViewControllerForIdentifierShouldReturnViewControllerWhenHelperMethodExists {
//    assertThat([_mgr rootViewControllerForFlow:@"any"], is(notNilValue()));
//}
//
//
//- (void)toDetailFrom:(UIViewController *) vc withUserInfo:(NSDictionary *) userInfo {
//    called = YES;
//    recordedVC = vc;
//    recorededUserInfo = userInfo;
//}
//
//- (UIViewController *)rootViewControllerForFlow:(NSString *)flowIdentifier {
//    return [[UIViewController alloc] init];
//}
//
//@end
