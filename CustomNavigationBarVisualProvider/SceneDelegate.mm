//
//  SceneDelegate.mm
//  CustomNavigationBarVisualProvider
//
//  Created by Jinwoo Kim on 4/27/23.
//

#import "SceneDelegate.hpp"
#import "CustomNavigationController.hpp"
#import "CustomNavigationBar.hpp"
#import "PurpleViewController.hpp"
#import "BlueViewController.hpp"

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:static_cast<UIWindowScene *>(scene)];
    PurpleViewController *purpleViewController = [PurpleViewController new];
    BlueViewController *blueViewController = [BlueViewController new];
    CustomNavigationController *navigationController = [[CustomNavigationController alloc] initWithNavigationBarClass:CustomNavigationBar.class toolbarClass:nil];
    [navigationController setViewControllers:@[purpleViewController, blueViewController] animated:NO];
    [purpleViewController release];
    [blueViewController release];
    window.rootViewController = navigationController;
    [navigationController release];
    [window makeKeyAndVisible];
    
    self.window = window;
    [window release];
}

@end
