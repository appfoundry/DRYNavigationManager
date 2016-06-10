//
//  DRYDefaultFlowTranslationDataSource.h
//  Pods
//
//  Created by Michael Seghers on 10/06/16.
//
//

#import <Foundation/Foundation.h>
#import "DRYNavigationTranslationDataSource.h"
#import "DRYFlowTranslationDataSource.h"

@interface DRYDefaultDataSource : NSObject <DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>

- (instancetype)initWithNavigatorClassRegistry:(NSDictionary<NSString *, Class> *)navRegistry viewControllerInitializerClassRegistry:(NSDictionary<NSString *, Class> *)viewControllerRegistry;

@end
