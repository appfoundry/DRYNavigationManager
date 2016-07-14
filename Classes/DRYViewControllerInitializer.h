//
//  DRYViewControllerInitializer.h
//  Pods
//
//  Created by Michael Seghers on 09/06/16.
//
//

#import <UIKit/UIKit.h>

@protocol DRYViewControllerInitializer <NSObject>

- (UIViewController *)viewControllerWithParameters:(NSDictionary *)parameters error:(NSError **)error;

@end
