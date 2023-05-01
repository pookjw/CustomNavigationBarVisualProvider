//
//  PurpleViewController.mm
//  CustomNavigationBarVisualProvider
//
//  Created by Jinwoo Kim on 4/27/23.
//

#import "PurpleViewController.hpp"

@implementation PurpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Purple";
    self.view.backgroundColor = UIColor.systemPurpleColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

@end
