//
// Created by Joris Dubois on 16/12/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRYNavigationTranslationDataSource.h"
#import "DRYFlowTranslationDataSource.h"

@interface DefaultNavigationTranslationDataSource : NSObject<DRYNavigationTranslationDataSource, DRYFlowTranslationDataSource>

@end