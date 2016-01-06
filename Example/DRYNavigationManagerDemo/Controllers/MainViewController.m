//
//  MainViewController.m
//  navigation-manager-poc
//
//  Created by Michael Seghers on 24/05/14.
//  Copyright (c) 2014 AppFoundry. All rights reserved.
//

#import <DRYNavigationManager/DRYNavigationManager.h>
#import "MainViewController.h"
#import "UIViewController+Reliant.h"
#import "NavigationConstants.h"

@interface MainViewController ()

@property (nonatomic, weak) DRYBaseNavigationManager *navigationManager;
@property (nonatomic, strong) NSArray *menu;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self injectSelf];
    
    self.menu = @[@"Partner", @"Chap", @"Buddy"];
    
    self.title = @"Main";
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.menu[(NSUInteger) indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedText = self.menu[(NSUInteger) indexPath.row];
    NSLog(@"selected row with value %@", selectedText);
	[_navigationManager navigateWithNavigationIdentifier:TO_HELLO_VIEW_IDENTIFIER parameters:@{@"selectedName": selectedText} hostViewController:self errorHandler:nil successHandler:nil];
    self.helloSayer.text = selectedText; // goes to nil if not iPad
}

@end
