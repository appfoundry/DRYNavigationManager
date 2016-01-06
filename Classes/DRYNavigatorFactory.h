//
// Created by Joris Dubois on 18/12/15.
//

#import <Foundation/Foundation.h>

@protocol DRYNavigator;

@protocol DRYNavigatorFactory <NSObject>

- (id<DRYNavigator>)navigatorForClass:(Class)className;

@end