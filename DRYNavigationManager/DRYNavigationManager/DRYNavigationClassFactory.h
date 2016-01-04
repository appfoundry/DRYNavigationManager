//
// Created by Joris Dubois on 18/12/15.
//

#import <Foundation/Foundation.h>

@protocol DRYNavigationClass;

@protocol DRYNavigationClassFactory <NSObject>

- (id<DRYNavigationClass>)navigationClassForClass:(Class)className;

@end