//
// Created by Joris Dubois on 04/01/16.
//

#import "DRYDefaultNavigationClassFactory.h"
#import "DRYNavigationClass.h"

@implementation DRYDefaultNavigationClassFactory

- (id<DRYNavigationClass>)navigationClassForClass:(Class)className {
	return (id <DRYNavigationClass>)[[className alloc] init];
}

@end