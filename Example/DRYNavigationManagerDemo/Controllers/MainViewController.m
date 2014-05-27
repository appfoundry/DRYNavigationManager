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

@interface MainViewController ()

@property (nonatomic, weak) id<DRYNavigationManager> navigationManager;
@property (nonatomic, strong) NSArray *menu;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injectSelf];
    
    self.menu = [[NSArray alloc] initWithObjects: @"Partner", @"Chap", @"Buddy", nil];
    
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
    cell.textLabel.text = self.menu[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedText = self.menu[indexPath.row];
    NSLog(@"selected row with value %@", selectedText);
    [_navigationManager navigateFromViewController:self withIdentifier:@"toDetail" withUserInfo:@{@"selectedName": selectedText}];

    self.helloSayer.text = selectedText; // goes to nil if not iPad
}

@end
