//
//  DRYDefaultFlowTranslationDataSource.m
//  Pods
//
//  Created by Michael Seghers on 10/06/16.
//
//

#import "DRYDefaultDataSource.h"

@interface DRYDefaultDataSource () {
    NSDictionary<NSString *, Class> *_navigatorClassRegistry;
    NSDictionary<NSString *, Class> *_viewControllerInitializerClassRegistry;
}

@end

@implementation DRYDefaultDataSource

- (instancetype)init
{
    return [self initWithNavigatorClassRegistry:@{} viewControllerInitializerClassRegistry:@{}];
}

- (instancetype)initWithNavigatorClassRegistry:(NSDictionary<NSString *, Class> *)navRegistry viewControllerInitializerClassRegistry:(NSDictionary<NSString *, Class> *)viewControllerRegistry {
    self = [super init];
    if (self) {
        _navigatorClassRegistry = navRegistry;
        _viewControllerInitializerClassRegistry = viewControllerRegistry;
    }
    return self;
}

- (Class)classNameForNavigationIdentifier:(NSString *)navigationIdentifier {
    return _navigatorClassRegistry[navigationIdentifier];
}

- (Class)classNameForFlowIdentifier:(NSString *)flowIdentifier {
    return _viewControllerInitializerClassRegistry[flowIdentifier];
}

@end
