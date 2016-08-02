//
//  DRYViewControllerInitializerFactory.h
//  Pods
//
//  Created by Michael Seghers on 09/06/16.
//
//

#import <Foundation/Foundation.h>

@protocol DRYViewControllerInitializer;

@protocol DRYViewControllerInitializerFactory <NSObject>

- (id<DRYViewControllerInitializer>)viewControllerInitializerForClass:(Class)className;

@end
