//
// Created by Michael Seghers on 23/05/14.
// Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import "DRYBaseNavigationManager.h"
#import "DRYNavigationHelper.h"

@interface DRYBaseNavigationManager () {
    NSObject<DRYNavigationHelper> *_navigationHelper;
}
@end

@implementation DRYBaseNavigationManager

- (id)initWithNavigationHelper:(NSObject<DRYNavigationHelper> *)navigationHelper {
    self = [super init];
    if (self) {
        _navigationHelper = navigationHelper;
    }
    return self;
}

- (UIViewController *)rootViewControllerForFlow:(id)flowIdentifier {
    return [_navigationHelper rootViewControllerForFlow:flowIdentifier];
}

- (void)navigateFromViewController:(UIViewController *)viewController withIdentifier:(NSString *)identifier withUserInfo:(NSDictionary *) userInfo  {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@From:withUserInfo:", identifier]);
    if ([_navigationHelper respondsToSelector:sel]) {
        IMP imp = [_navigationHelper methodForSelector:sel];
        void (*func)(id, SEL, UIViewController *, NSDictionary *) = (void *) imp;
        func(_navigationHelper, sel, viewController, userInfo);
    }
}

- (void)unwindViewController:(UIViewController *)viewController {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"unwindFrom%@:", NSStringFromClass([viewController class])]);
    if ([_navigationHelper respondsToSelector:sel]) {
        IMP imp = [_navigationHelper methodForSelector:sel];
        void (*func)(id, SEL, UIViewController *) = (void *) imp;
        func(_navigationHelper, sel, viewController);
    } else {
        UIViewController *presenter = viewController.presentingViewController;
        [presenter dismissViewControllerAnimated:YES completion:^{
            SEL unwindSelector =  NSSelectorFromString([NSString stringWithFormat:@"didDismiss%@:toPresenter:", NSStringFromClass([viewController class])]);
            if ([_navigationHelper respondsToSelector:unwindSelector]) {
                IMP imp = [_navigationHelper methodForSelector:unwindSelector];
                void (*func)(id, SEL, UIViewController *, UIViewController *) = (void *) imp;
                func(_navigationHelper, sel, viewController, presenter);
            }
        }];
    }
}

@end