//
//  ProjectsViewController.h
//  myTRacker
//
//  Created by Andrea Herbas on 1/2/14.
//
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@interface ProjectsViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
