//
// Created by Jens Goeman on 24/11/15.
// Copyright (c) 2015 AppFoundry. All rights reserved.
//

@import Foundation;

@protocol DRYNavigator;

@protocol DRYNavigationTranslationDataSource <NSObject>

- (Class)classNameForNavigationIdentifier:(NSString *)navigationIdentifier;

@end