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
    
    [self setupRestKit];
    
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

- (void)setupRestKit{
    
    NSError *error = nil;
    //NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Model" ofType:@"mom"]];
    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];//[[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Configure the object manager
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]];
    [[objectManager HTTPClient] setDefaultHeader:@"X-Login-Token" value:@"WySKtLx96qr83Tog6"];
    [[objectManager HTTPClient] setDefaultHeader:@"X-User-Id" value:@"SGfE7i6DubfXJ7LBo"];
    
    objectManager.managedObjectStore = managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    
    RKEntityMapping *projectMapping = [RKEntityMapping mappingForEntityForName:@"Project" inManagedObjectStore:managedObjectStore];
    [projectMapping addAttributeMappingsFromDictionary:@{
     @"_id": @"id",
     @"name": @"name",
     @"description": @"desc",
     @"length": @"length",
     @"velocity": @"velocity",
     @"startAt": @"startAt",
     @"createdAt": @"createdAt",
     @"updatedAt": @"updatedAt"}];
    projectMapping.identificationAttributes = @[@"id"];
    
    RKResponseDescriptor *projectResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:projectMapping method:RKRequestMethodGET pathPattern:@"api/projects" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:projectResponseDescriptor];
    
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"Story" inManagedObjectStore:managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:@{
     @"_id": @"id",
     @"title": @"title",
     @"description": @"desc",
     @"type": @"type",
     @"status": @"status",
     @"points": @"points",
     @"project_id": @"project_id",
     @"createdAt": @"createdAt",
     @"updatedAt": @"updatedAt"}];
    entityMapping.identificationAttributes = @[@"id"];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping method:RKRequestMethodGET pathPattern:@"api/projects/QB4wnfjxKbai7xjXY/stories" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    TableViewController *controller = (TableViewController *)((UINavigationController *)tabBarController.viewControllers[0]).topViewController;
    controller.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    
    SecondViewController *controller1 = (SecondViewController *)((UINavigationController *)tabBarController.viewControllers[1]).topViewController;
    controller1.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
}

@end
