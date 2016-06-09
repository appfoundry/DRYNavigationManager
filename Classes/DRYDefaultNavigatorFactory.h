//
// Created by Joris Dubois on 04/01/16.
//

#import <Foundation/Foundation.h>
#import "DRYNavigatorFactory.h"
#import "DRYViewControllerInitializerFactory.h"

@interface DRYDefaultNavigatorFactory : NSObject<DRYNavigatorFactory, DRYViewControllerInitializerFactory>
@end