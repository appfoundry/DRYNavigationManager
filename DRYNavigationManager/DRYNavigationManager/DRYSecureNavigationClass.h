//
// Created by Joris Dubois on 04/01/16.
//

#import <Foundation/Foundation.h>
#import "DRYNavigationClass.h"

@protocol DRYSecureNavigationClass <DRYNavigationClass>

- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

@end