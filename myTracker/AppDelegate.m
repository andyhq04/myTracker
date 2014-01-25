//
//  AppDelegate.m
//  myTRacker
//
//  Created by Andrea Herbas on 12/26/13.
//
//

#import "AppDelegate.h"

#import "TableViewController.h"

#import "SecondViewController.h"

#import "LoginViewController.h"

#import "Project.h"
#import "APIConnector.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    ProjectsViewController *projectViewController = [[ProjectsViewController alloc]initWithNibName:@"ProjectsViewController" bundle:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    TableViewController *viewController1 = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    viewController1.projectsViewController = projectViewController;
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    [navigationController1 setToolbarHidden:NO];
    
    SecondViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    viewController2.projectsViewController = projectViewController;
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    [navigationController2 setToolbarHidden:NO];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navigationController1, navigationController2];
    
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:self.tabBarController.view];
    
    [self.window makeKeyAndVisible];
    
    LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    loginViewController.delegate = self;
    [self.tabBarController presentViewController:loginViewController animated:NO completion:NULL];

    return YES;
}

- (void)loginViewControllerDidFinish:(LoginViewController *)loginViewController {
    [self.tabBarController dismissViewControllerAnimated:NO completion:NULL];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
