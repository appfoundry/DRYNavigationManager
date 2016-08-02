//
//  DRYFlowTranslationDataSource.h
//  Pods
//
//  Created by Michael Seghers on 09/06/16.
//
//

#import <Foundation/Foundation.h>

@protocol DRYFlowTranslationDataSource <NSObject>

- (Class)classNameForFlowIdentifier:(NSString *)flowIdentifier;

@end
