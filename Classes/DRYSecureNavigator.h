//
// Created by Joris Dubois on 04/01/16.
//

@import Foundation;
#import "DRYNavigator.h"

@protocol DRYSecureNavigator <DRYNavigator>

- (void)hasAccessWithParameters:(NSDictionary *)parameters errorHandler:(DRYNavigationErrorHandler)errorHandler successHandler:(DRYNavigationSuccessHandler)successHandler;

@end