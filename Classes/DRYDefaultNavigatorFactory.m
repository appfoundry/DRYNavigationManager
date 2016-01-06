//
// Created by Joris Dubois on 04/01/16.
//

#import "DRYDefaultNavigatorFactory.h"
#import "DRYNavigator.h"

@implementation DRYDefaultNavigatorFactory

- (id<DRYNavigator>)navigatorForClass:(Class)className {
	return (id <DRYNavigator>)[[className alloc] init];
}

@end